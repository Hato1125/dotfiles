sketchybar --add item brew left                                       \
           --set brew                                                 \
             icon="󰆧"                                                 \
             icon.font.size=20                                        \
             icon.padding_left=16                                     \
             label.padding_right=16                                   \
             background.color=${BREW_BRACKET_BACK_COLOR}              \
             background.border_color=${BREW_BRACKET_BORDER_COLOR}     \
             background.border_width=1                                \
             background.height=34                                     \
             background.corner_radius=$[34/2]                         \
             script="${PLUGINS_DIR}/brew.sh"                          \
             click_script="${PLUGINS_DIR}/brew.sh"                    \
             update_freq=3600                                         \
