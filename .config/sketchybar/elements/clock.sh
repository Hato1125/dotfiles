#!/bin/sh

sketchybar --add item clock right               \
           --set clock                          \
             icon="󰥔"                           \
             icon.font.size=19                  \
             script="${PLUGINS_DIR}/clock.sh"   \
             update_freq=10                     \
