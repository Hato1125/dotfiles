apple_accent_color_index=$(defaults read -g AppleAccentColor)

case ${apple_accent_color_index} in
  0) ACCENT_COLOR=${RED} ;;
  1) ACCENT_COLOR=${ORANCE} ;;
  2) ACCENT_COLOR=${YELLOW} ;;
  3) ACCENT_COLOR=${GREEN} ;;
  5) ACCENT_COLOR=${PURPLE} ;;
  6) ACCENT_COLOR=${PINK} ;;
  *) ACCENT_COLOR=${BLUE} ;;
esac
