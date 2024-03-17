#!/bin/sh

mode=$(defaults read -g AppleInterfaceStyle)

if [ "$mode" == "Dark" ]; then
  source ${THEMES_DIR}/night_theme.sh
else
  source ${THEMES_DIR}/light_theme.sh
fi
