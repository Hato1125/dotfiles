update_num=$(brew outdated | grep -c .)

if [ 0 -lt $update_num  ]; then
  sketchybar --set ${NAME} icon="󰆧" label="There are ${update_num} updates!"
else
  sketchybar --set ${NAME} icon="󱐝" label="No updates."
fi
