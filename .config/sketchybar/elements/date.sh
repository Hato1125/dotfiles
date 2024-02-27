#!/bin/sh

sketchybar --add item date right                \
           --set date                           \
             icon="󰃮"                           \
             icon.font.size=19                  \
             script="${PLUGINS_DIR}/date.sh"    \
             update_freq=10                     \
