if [ -n $(command -v brew) ]; then
  update_num=$(brew outdated | grep -c .)
  if [ 0 -lt $update_num  ]; then
    result_icon="󰆧"
    result_icon_size=20
    result_label="${update_num}"
    result_is_error=0
  else
    result_icon="󱐝"
    result_icon_size=20
    result_label="0"
    result_is_error=off
  fi
else
  result_icon=""
  result_icon_size=15
  result_label=""
  result_is_error=on
fi

sketchybar --set ${NAME}                                \
             icon="${result_icon}"                      \
             icon.font.size=${result_icon_size}         \
             icon.highlight=${result_is_error}          \
             label="${result_label}"                    \
             label.highlight=${result_is_error}         \
