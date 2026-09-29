#!/bin/bash

exec gamescope \
  -w 1920 \
  -h 1080 \
  -W 2880 \
  -H 1620 \
  -b \
  -o 60 \
  -s 2.5 \
  --force-grab-cursor \
  --hdr-enabled \
  --cursor-scale-height 1620 \
  --backend sdl \
  --mangoapp \
  -- "$@"
