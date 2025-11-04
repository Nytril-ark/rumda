
#!/bin/bash


MODE="$1"
WALLDIR="/home/$USER/.config/rumda-pistachio/pictures"

# Pick wallpaper based on mode

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

# Try adding image extensions automatically

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

# Ensure daemon is running

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

