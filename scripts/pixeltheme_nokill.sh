#!/bin/bash
 
if [ -z "$1" ]; then
  echo "Usage: $0 <dark|light>"
  exit 1
fi
 
if [ "$1" != "dark" ] && [ "$1" != "light" ]; then
  echo "Error: Argument must be 'dark' or 'light'"
  exit 1
fi
 
if [ "$1" = "light" ]; then
  WALLPAPER="$HOME/.config/rumda/pictures/nazhim-pixel.png"
else
  WALLPAPER="$HOME/.config/rumda/pictures/wallpaper-warm.png"
fi
 
swww img "$WALLPAPER" \
  --transition-type grow \
  --transition-pos bottom-left \
  --transition-duration 1 \
  --transition-bezier 0.4,0.0,0.2,1.0
 
/$HOME/.config/rumda/scripts/pixel_hypr.sh $1
/$HOME/.config/rumda/scripts/alacrittytheme.sh $1
 
notify-send "Rumda" "switched to pixel theme."
