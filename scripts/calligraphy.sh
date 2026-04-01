#!/usr/bin/env bash
RUMDA_DIR="$HOME/.config/rumda"
SVG_SCRIPT="$HOME/.config/rumda/scripts/rofi_poetry.py"
SVG_NEW="$RUMDA_DIR/light-config/rofi/calligraphy/bg_new.svg"
PNG_OUTPUT="$RUMDA_DIR/light-config/rofi/calligraphy/bg_new.png"
ROFI_CONF="$RUMDA_DIR/light-config/rofi/calligraphy/config.rasi"
ROFI_CONF_TMP="/tmp/calligraphy_config.rasi"

python3 "$SVG_SCRIPT" '#8f6952' '#f2d5bb' || { echo "SVG update failed"; exit 1; }
inkscape "$SVG_NEW" -o "$PNG_OUTPUT" || { echo "SVG to PNG failed"; exit 1; }

sed "s|bg_new.png|$PNG_OUTPUT|g" "$ROFI_CONF" > "$ROFI_CONF_TMP"

rofi -show drun -theme "$ROFI_CONF_TMP"
