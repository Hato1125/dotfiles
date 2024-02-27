#!/bin/sh

source ${ELEMENTS_DIR}/open_finder.sh
source ${ELEMENTS_DIR}/open_terminal.sh
source ${ELEMENTS_DIR}/open_zed.sh

sketchybar --add bracket appbar open_finder open_terminal open_zed    \
           --set appbar                                               \
             background.color=${APPBAR_BRACKET_BACK_COLOR}            \
             background.border_color=${APPBAR_BRACKET_BORDER_COLOR}   \
             background.border_width=1                                \
             background.height=34                                     \
             background.corner_radius=$[34/2]                         \
