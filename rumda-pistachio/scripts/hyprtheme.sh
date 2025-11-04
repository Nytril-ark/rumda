#!/bin/bash
# usage: hyprtheme light / hyprtheme dark

# note to self: the old copy script results in no white blink when switching
# but the symlink does that. possibly cuz of the rm -f 

set -e

THEME="$1"
RUMDA_DIR="$HOME/.config/rumda-pistachio"
COMMON_FILE="$HOME/.config/hypr/hyprland.conf"

case "$THEME" in
  light)
    SRC="$RUMDA_DIR/light-config/hypr/hyprland.conf"
    ;;
  dark)
    SRC="$RUMDA_DIR/dark-config/hypr/hyprland.conf"
    ;;
  *)
    echo "Usage: $0 [light|dark]"
    exit 1
    ;;
esac

if [[ ! -f "$SRC" ]]; then
  echo "❌ Theme config not found at: $SRC"
  exit 1
fi

sleep 0.9

rm -f "$COMMON_FILE"

ln -fs "$SRC" "$COMMON_FILE"

/home/$USER/.config/rumda-pistachio/scripts/alacrittytheme.sh "$THEME"

/home/$USER/.config/rumda-pistachio/scripts/yazitheme.sh "$THEME"

/home/$USER/.config/rumda-pistachio/scripts/zathuratheme.sh "$THEME"

hyprctl reload >/dev/null 2>&1 || true

echo "Switched to '$THEME' theme"

