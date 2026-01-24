#!/bin/bash

COMMON_FILE="$HOME/.config/alacritty/alacritty.toml"
SRC="$HOME/.config/rumda/flavours/warm-rumda/alacritty.toml"

ln -fs "$SRC" "$COMMON_FILE"

