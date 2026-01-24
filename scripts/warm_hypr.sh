#!/bin/bash

COMMON_FILE="$HOME/.config/hypr/hyprland.conf"
SRC="$HOME/.config/rumda/flavours/warm-rumda/hyprland.conf"

ln -fs "$SRC" "$COMMON_FILE"
