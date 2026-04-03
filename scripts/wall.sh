#!/bin/bash


MODE="$1"
WALLDIR="/home/$USER/.config/rumda/pictures"

case "$MODE" in
dark)
IMG="$WALLDIR/dark-wallpaper"
;;
light)
IMG="$WALLDIR/light-wallpaper"
;;
*)
echo "Usage: $0 [dark|light]"
exit 1
;;
esac

if [[ ! -f "$IMG" ]]; then
if [[ -f "$IMG.png" ]]; then
IMG="$IMG.png"
elif [[ -f "$IMG.jpg" ]]; then
IMG="$IMG.jpg"
else
echo "Error: wallpaper not found for mode '$MODE'."
exit 1
fi
fi

if ! pgrep -x "swww-daemon" >/dev/null; then
echo "Starting swww-daemon..."
swww-daemon &
sleep 1
fi

swww img "$IMG" \
  --transition-type grow \
  --transition-pos top-right \
  --transition-duration 1 \
  --transition-bezier 0.4,0.0,0.2,1.0 \

