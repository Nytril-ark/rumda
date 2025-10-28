#!/bin/bash
# usage: hyprtheme [light|dark]

set -e

THEME="$1"
RUMDA_DIR="$HOME/.config/rumda"
COMMON_FILE="$RUMDA_DIR/common/hypr/hyprland.conf"

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

cp "$SRC" "$COMMON_FILE"

./alacrittytheme.sh $THEME

hyprctl reload >/dev/null 2>&1 || true





