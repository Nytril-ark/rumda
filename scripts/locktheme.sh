#!/bin/bash
# usage: locktheme [light|dark]

set -e

THEME="$1"
RUMDA_DIR="$HOME/.config/rumda"
COMMON_FILE="$HOME/.config/hypr/hyprlock.conf"

case "$THEME" in
  light)
    SRC="$RUMDA_DIR/light-config/hypr/hyprlock.conf"
    ;;
  dark)
    SRC="$RUMDA_DIR/dark-config/hypr/hyprlock.conf"
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

ln -sf "$SRC" "$COMMON_FILE"

