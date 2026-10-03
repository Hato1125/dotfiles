#!/bin/bash

if [[ "$1" == "--" ]]; then
  shift
fi

if [[ $# -eq 0 ]]; then
  printf 'game: error: missing COMMAND\n' >&2
  exit 1
fi

export DXVK_FRAME_PACE=low-latency
export PROTON_USE_WAYLAND=1
export PROTON_FSR4_UPGRADE=1
export PROTON_DXVK_LOWLATENCY=1

export PIPEWIRE_LATENCY=32/48000
export PIPEWIRE_ALSA="{
  alsa.format=S16_LE
  alsa.rate=48000
  alsa.channels=2
  alsa.period-size=8
  alsa.periods=2
}"

scxctl switch --sched lavd --mode gaming
app2unit -- gamemoderun pw-jack "$@"
