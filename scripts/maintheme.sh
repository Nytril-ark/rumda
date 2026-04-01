#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <dark|light>"
  exit 1
fi

if [ "$1" != "dark" ] && [ "$1" != "light" ]; then
  echo "Error: Argument must be 'dark' or 'light'"
  exit 1
fi


swww img /$HOME/.config/rumda/pictures/light-wallpaper.png \
  --transition-type grow \
  --transition-pos bottom-left \
  --transition-duration 1 \
  --transition-bezier 0.4,0.0,0.2,1.0 \

/$HOME/.config/rumda/scripts/hyprtheme.sh $1

killall quickshell
quickshell -p ~/.config/rumda/common/quickshell/shell.qml > /dev/null 2>&1 & disown

notify-send "Rumda" "switched to main theme."

