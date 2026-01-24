#!/bin/bash

swww img /$HOME/.config/rumda/pictures/nazhim-warm.png  \
  --transition-type grow \
  --transition-pos bottom-left \
  --transition-duration 1 \
  --transition-bezier 0.4,0.0,0.2,1.0 \

/$HOME/.config/rumda/scripts/warm_hypr.sh
/$HOME/.config/rumda/scripts/warm_alacritty.sh

notify-send "Rumda" "switched to warm theme."

