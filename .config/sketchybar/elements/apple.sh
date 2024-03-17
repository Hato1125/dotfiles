#!/bin/sh

sketchybar --add item apple left                                            \
           --set apple                                                      \
             icon=""                                                      \
             icon.font.size=23                                              \
             y_offset=1                                                     \
             click_script="sketchybar -m --set \$NAME popup.drawing=toggle" \

sketchybar --add item apple.sleep popup.apple                               \
           --set apple.sleep                                                \
             icon="󰒲"                                                       \
             label="Sleep"                                                  \
             click_script="pmset sleepnow
                           sketchybar -m --set apple popup.drawing=off"     \

sketchybar --add item apple.restart popup.apple                             \
           --set apple.restart                                              \
             icon="󰜉"                                                       \
             label="Restart"                                                \
             click_script="shutdown -r now
                           sketchybar -m --set apple popup.drawing=off"     \

sketchybar --add item apple.shutdown popup.apple                            \
           --set apple.shutdown                                             \
             icon="󰐥"                                                       \
             label="Shutdown"                                               \
             click_script="shutdown -h now
                           sketchybar -m --set apple popup.drawing=off"     \
