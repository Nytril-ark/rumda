#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <dark|light>"
  exit 1
fi

if [ "$1" != "dark" ] && [ "$1" != "light" ]; then
  echo "Error: Argument must be 'dark' or 'light'"
  exit 1
fi

COMMON_FILE="$HOME/.config/hypr/hyprland.conf"
SRC="$HOME/.config/rumda/flavours/pixel-rumda/$1/hyprland.conf"

ln -fs "$SRC" "$COMMON_FILE"
