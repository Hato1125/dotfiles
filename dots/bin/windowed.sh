#!/bin/sh

gamescope \
  -w 2880 \
  -h 1620 \
  -W 2880 \
  -H 1620 \
  -b \
  -o 60 \
  -s 3.0 \
  --force-grab-cursor \
  --cursor-scale-height 1620 \
  --backend sdl \
  -- "$@"
