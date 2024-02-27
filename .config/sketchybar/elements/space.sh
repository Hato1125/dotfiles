#!/bin/sh

source ${ELEMENTS_DIR}/appname.sh

SPACE_ICONS=(1 2 3 4 5)

for i in ${!SPACE_ICONS[@]}
do
  SID=$[$i+1]

  sketchybar --add space space.${SID} center                          \
             --set space.${SID}                                       \
               space=${SID}                                           \
               icon.color=${SPACE_INACTIVE_ICON_COLOR}                \
               icon.highlight_color=${SPACE_ACTIVE_ICON_COLOR}        \
               icon=${SPACE_ICONS[i]}                                 \
               icon.font.family="monaspace Radon"                     \
               icon.font.style="bold"                                 \
               icon.font.size=13                                      \
               icon.padding_left=8                                    \
               icon.padding_right=1                                   \
               icon.align=center                                      \
               background.height=25                                   \
               background.padding_left=4                              \
               background.padding_right=4                             \
               background.corner_radius=$[25/2]                       \
               background.color=${SPACE_ACTIVE_BACK_COLOR}            \
               script=${PLUGINS_DIR}/space.sh                         \
               associated_space=${SID}
done

sketchybar --add bracket spaces appname '/space\..*/'                 \
           --set spaces                                               \
             background.color=${SPACE_BRACKET_BACK_COLOR}             \
             background.border_color=${SPACE_BRACKET_BORDER_COLOR}    \
             background.border_width=1                                \
             background.height=34                                     \
             background.corner_radius=$[34/2]                         \
