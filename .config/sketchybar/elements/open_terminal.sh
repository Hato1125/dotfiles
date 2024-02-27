#!/bin/sh

sketchybar --add item open_terminal left                      \
           --set open_terminal                                \
             icon=""                                        \
             icon.font.size=18                                \
             click_script="open -a /Applications/iTerm.app"   \
             background.padding_left=8                        \
             background.padding_right=8                       \
