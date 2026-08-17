#!/bin/bash

audio_lowlatency=false
usb_overclock=true
usb_overclock_applied=false

disable_hda_power_save=false
hda_power_save=0
hda_power_save_controller="N"
sudo_keepalive_pid=""
askpass_helper=""
needs_root=false

readonly HDA_POWER_SAVE_PATH="/sys/module/snd_hda_intel/parameters/power_save"
readonly HDA_POWER_SAVE_CONTROLLER_PATH="/sys/module/snd_hda_intel/parameters/power_save_controller"
readonly USB_OC_PARAM_PATH="/sys/module/usb_oc/parameters/interrupt_interval_override"

log() {
  echo "game: $*"
}

error() {
  echo "game: error: $*" >&2
}

usage() {
  cat <<'EOF'
Usage:
  game.sh [OPTIONS] -- COMMAND [ARGS...]

Options:
  --enable-audio-lowlatency      Run through pw-jack and set low-latency PipeWire options.
  --disable-usb-overclock        Do not apply USB overclock override.
  -h, --help                     Show this help.

Examples:
  game.sh --enable-audio-lowlatency -- %command%

Environment:
  USB_OC_DEVICES                 Space-separated USB devices for usb_oc override.
  SUDO_ASKPASS                   Optional GUI askpass helper for sudo -A.
EOF
}

setup_sudo_askpass() {
  if [[ -n "${SUDO_ASKPASS:-}" && -x "$SUDO_ASKPASS" ]]; then
    return 0
  fi

  local askpass
  for askpass in \
    /usr/bin/ksshaskpass \
    /usr/lib/ssh/ksshaskpass \
    /usr/bin/ssh-askpass \
    /usr/lib/ssh/ssh-askpass \
    /usr/libexec/openssh/ssh-askpass; do
    if [[ -x "$askpass" ]]; then
      export SUDO_ASKPASS="$askpass"
      return 0
    fi
  done

  if command -v zenity >/dev/null 2>&1; then
    askpass_helper="$(mktemp "${TMPDIR:-/tmp}/game-askpass.XXXXXX")" || return 1
    cat > "$askpass_helper" <<'EOF'
#!/bin/sh
zenity --password --title="Administrator privileges required" 2>/dev/null
EOF
    chmod 700 "$askpass_helper" || return 1
    export SUDO_ASKPASS="$askpass_helper"
    return 0
  fi

  if command -v kdialog >/dev/null 2>&1; then
    askpass_helper="$(mktemp "${TMPDIR:-/tmp}/game-askpass.XXXXXX")" || return 1
    cat > "$askpass_helper" <<'EOF'
#!/bin/sh
kdialog --password "Administrator privileges required" 2>/dev/null
EOF
    chmod 700 "$askpass_helper" || return 1
    export SUDO_ASKPASS="$askpass_helper"
    return 0
  fi

  error "no GUI askpass program found; install ksshaskpass, ssh-askpass, zenity, or kdialog"
  return 1
}

start_sudo_session() {
  if [[ "$needs_root" != true ]]; then
    return 0
  fi

  setup_sudo_askpass || return 1

  log "requesting administrator privileges"
  sudo -A -v || return 1

  while true; do
    sudo -n -v 2>/dev/null || exit
    sleep 60
  done &

  sudo_keepalive_pid=$!
}

run_root() {
  sudo -n sh -c "$1" sh "${@:2}"
}

# usb_oc expects comma-separated vid:pid:interval entries (e.g. 05ac:024f:1,31e3:1322:1)
usb_oc_param_value() {
  local interval="$1" value="" dev
  for dev in $USB_OC_DEVICES; do
    value+="${value:+,}${dev}:${interval}"
  done
  printf '%s' "$value"
}

cleanup() {
  if [[ "$usb_overclock_applied" == true && -n "${USB_OC_DEVICES:-}" ]]; then
    log "clearing USB overclock override for: $USB_OC_DEVICES"
    run_root 'echo -n "$1" > "$2"' "$(usb_oc_param_value 0)" "$USB_OC_PARAM_PATH" || {
      error "failed to clear USB overclock override"
    }
  fi

  if [[ "$disable_hda_power_save" == true ]]; then
    run_root '
      echo "$1" > "$3"
      echo "$2" > "$4"
    ' "$hda_power_save" "$hda_power_save_controller" "$HDA_POWER_SAVE_PATH" "$HDA_POWER_SAVE_CONTROLLER_PATH"
  fi

  if [[ -n "$sudo_keepalive_pid" ]]; then
    kill "$sudo_keepalive_pid" 2>/dev/null
  fi

  if [[ -n "$askpass_helper" ]]; then
    rm -f "$askpass_helper"
  fi
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      usage
      exit 0
      ;;
    --enable-audio-lowlatency)
      audio_lowlatency=true
      shift
      ;;
    --disable-usb-overclock)
      usb_overclock=false
      shift
      ;;
    --)
      shift
      break
      ;;
    -*)
      error "unknown option: $1"
      echo "Try 'game.sh --help' for usage." >&2
      exit 1
      ;;
    *)
      break
      ;;
  esac
done

if [[ $# -eq 0 ]]; then
  error "missing COMMAND"
  echo "Try 'game.sh --help' for usage." >&2
  exit 1
fi

export DXVK_FRAME_PACE=low-latency
export PROTON_USE_WAYLAND=1
export PROTON_FSR4_UPGRADE=1
export PROTON_DXVK_LOWLATENCY=1

if [[ "$usb_overclock" == true && -n "${USB_OC_DEVICES:-}" ]]; then
  needs_root=true
fi

if [[ "$audio_lowlatency" == true &&
      -e "$HDA_POWER_SAVE_PATH" &&
      "$(<"$HDA_POWER_SAVE_PATH")" != "0" &&
      -e "$HDA_POWER_SAVE_CONTROLLER_PATH" &&
      "$(<"$HDA_POWER_SAVE_CONTROLLER_PATH")" != "N" ]]; then
  needs_root=true
fi

trap cleanup EXIT INT TERM

start_sudo_session || {
  error "failed to get administrator privileges"
  exit 1
}

scxctl switch --sched lavd --mode gaming

if [[ "$usb_overclock" == true ]]; then
  if [[ -n "${USB_OC_DEVICES:-}" ]]; then
    if [[ ! -e "$USB_OC_PARAM_PATH" ]]; then
      log "loading usb_oc module"
      run_root 'modprobe usb_oc' || {
        error "failed to load usb_oc module"
        exit 1
      }
    fi

    log "applying USB overclock override for: $USB_OC_DEVICES"
    run_root 'echo -n "$1" > "$2"' "$(usb_oc_param_value 1)" "$USB_OC_PARAM_PATH" || {
      error "failed to apply USB overclock override"
      exit 1
    }
    usb_overclock_applied=true
  else
    log "USB overclock enabled, but USB_OC_DEVICES is not set; skipping"
  fi
fi

if [[ "$audio_lowlatency" == true ]]; then
  log "enabling low-latency audio mode"

  export PIPEWIRE_LATENCY=32/48000
  export PIPEWIRE_ALSA="{
    alsa.format=S16_LE
    alsa.rate=48000
    alsa.channels=2
    alsa.period-size=8
    alsa.periods=2
  }"

  if [[ -e "$HDA_POWER_SAVE_PATH" &&
        "$(<"$HDA_POWER_SAVE_PATH")" != "0" &&
        -e "$HDA_POWER_SAVE_CONTROLLER_PATH" &&
        "$(<"$HDA_POWER_SAVE_CONTROLLER_PATH")" != "N" ]]; then
    hda_power_save="$(<"$HDA_POWER_SAVE_PATH")"
    hda_power_save_controller="$(<"$HDA_POWER_SAVE_CONTROLLER_PATH")"

    if run_root '
      set -e
      echo 0 > "$1"
      echo N > "$2"
    ' "$HDA_POWER_SAVE_PATH" "$HDA_POWER_SAVE_CONTROLLER_PATH"; then
      disable_hda_power_save=true
    else
      error "failed to disable HDA power save; continuing without it"
    fi
  fi

  app2unit -- gamemoderun pw-jack "$@"
else
  app2unit -- gamemoderun "$@"
fi
