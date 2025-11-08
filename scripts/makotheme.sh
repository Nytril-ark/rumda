#!/bin/bash
# usage: makotheme [light|dark]

set -e

THEME="$1"
RUMDA_DIR="$HOME/.config/rumda"
COMMON_FILE="$HOME/.config/mako/config"

case "$THEME" in
  light)
    SRC="$RUMDA_DIR/light-config/mako/config"
    ;;
  dark)
    SRC="$RUMDA_DIR/dark-config/mako/config"
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

makoctl reload

