#!/bin/bash

swww img /$HOME/.config/rumda/pictures/nazhim-warm.png  \
  --transition-type grow \
  --transition-pos bottom-left \
  --transition-duration 1 \
  --transition-bezier 0.4,0.0,0.2,1.0 \

/$HOME/.config/rumda/scripts/warm_hypr.sh
/$HOME/.config/rumda/scripts/warm_alacritty.sh

killall quickshell
quickshell -p ~/.config/rumda/flavours/warm-rumda/quickshell/shell.qml > /dev/null 2>&1 & disown

notify-send "Rumda" "switched to warm theme."

