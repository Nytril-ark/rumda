#!/bin/bash
# usage: hyprtheme [light|dark]

set -e

THEME="$1"
RUMDA_DIR="$HOME/.config/rumda"
COMMON_FILE="$HOME/.config/zathura/zathurarc"

case "$THEME" in
  light)
    SRC="$RUMDA_DIR/light-config/zathura/zathurarc"
    ;;
  dark)
    SRC="$RUMDA_DIR/dark-config/zathura/zathurarc"
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

