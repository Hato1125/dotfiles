#!/bin/bash

out_w=2880
out_h=1620
fsr_scale=100
fsr_sharpness=2

help() {
  cat <<'EOF'
Usage:
  windowed.sh [OPTIONS] -- COMMAND [ARGS...]

Options:
  --fsr PERCENT    Render at PERCENT of the output resolution and upscale
                   with FSR (25-100). 100 disables FSR.
  --sharpness N    FSR sharpness (0-20, 0 is sharpest). Default: 2.
                   Ignored unless FSR is enabled.
  -h, --help       Show this help.

Examples:
  windowed.sh --fsr 80 -- %command%
  windowed.sh --fsr 80 --sharpness 5 -- %command%
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      help
      exit 0
      ;;
    --fsr)
      if [[ $# -lt 2 ]]; then
        printf 'windowed: error: --fsr requires a percentage\n' >&2
        exit 1
      fi
      fsr_scale="$2"
      shift 2
      ;;
    --fsr=*)
      fsr_scale="${1#--fsr=}"
      shift
      ;;
    --sharpness)
      if [[ $# -lt 2 ]]; then
        printf 'windowed: error: --sharpness requires a value\n' >&2
        exit 1
      fi
      fsr_sharpness="$2"
      shift 2
      ;;
    --sharpness=*)
      fsr_sharpness="${1#--sharpness=}"
      shift
      ;;
    --)
      shift
      break
      ;;
    *)
      break
      ;;
  esac
done

fsr_scale="${fsr_scale%\%}"

case "$fsr_scale" in
  ''|*[!0-9]*)
    printf 'windowed: error: invalid --fsr value: %s\n' "$fsr_scale" >&2
    exit 1
    ;;
esac

if [[ "$fsr_scale" -lt 25 || "$fsr_scale" -gt 100 ]]; then
  printf 'windowed: error: --fsr must be between 25 and 100\n' >&2
  exit 1
fi

case "$fsr_sharpness" in
  ''|*[!0-9]*)
    printf 'windowed: error: invalid --sharpness value: %s\n' "$fsr_sharpness" >&2
    exit 1
    ;;
esac

if [[ "$fsr_sharpness" -gt 20 ]]; then
  printf 'windowed: error: --sharpness must be between 0 and 20\n' >&2
  exit 1
fi

if [[ $# -eq 0 ]]; then
  printf 'windowed: error: missing COMMAND\n' >&2
  printf "Try 'windowed.sh --help' for usage.\n" >&2
  exit 1
fi

if [[ "$fsr_scale" -lt 100 ]]; then
  set -- -F fsr --sharpness "$fsr_sharpness" -- "$@"
else
  set -- -- "$@"
fi

exec gamescope \
  -w "$(((out_w * fsr_scale / 100) / 2 * 2))" \
  -h "$(((out_h * fsr_scale / 100) / 2 * 2))" \
  -W "$out_w" \
  -H "$out_h" \
  -b \
  -o 60 \
  -s 2.5 \
  --force-grab-cursor \
  --hdr-enabled \
  --cursor-scale-height "$out_h" \
  --backend sdl \
  "$@"
