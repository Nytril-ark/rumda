#!/usr/bin/env bash
# usage: hyprtheme [light|dark]
set -euo pipefail

# Paths
COMMON="$HOME/.config/rumda/common/hypr"
LIGHT="$HOME/.config/rumda/light-config/hypr/hyprland.conf"
DARK="$HOME/.config/rumda/dark-config/hypr/hyprland.conf"
TARGET="$COMMON/hyprland.conf"

# Argument check
if [[ $# -ne 1 ]]; then
  echo "Usage: $0 [light|dark]" >&2
  exit 1
fi

THEME="$1"

case "$THEME" in
  light) SRC="$LIGHT" ;;
  dark)  SRC="$DARK" ;;
  *) echo "Invalid theme: $THEME"; exit 1 ;;
esac

if [[ ! -f "$SRC" ]]; then
  echo "Error: source config not found at $SRC" >&2
  exit 2
fi

mkdir -p "$COMMON"

# Atomic replace: copy to temp, then move into place
TMP="$(mktemp --tmpdir="$COMMON" hypr.XXXXXX.conf)"
cp --preserve=mode,ownership,timestamps "$SRC" "$TMP"
mv --force "$TMP" "$TARGET"


