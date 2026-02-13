#!/usr/bin/sh

tmp=$(mktemp --suffix=.png)

grim -g "$(slurp)" "$tmp" &&
tesseract "$tmp" stdout 2>/dev/null | wl-copy

rm -f "$tmp"
