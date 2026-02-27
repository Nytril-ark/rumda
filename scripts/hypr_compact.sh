#!/bin/bash

STATE_FILE="/tmp/hypr_gaps_lolz"

if [ -f "$STATE_FILE" ]; then
    hyprctl keyword general:gaps_out "45,40,45,40"
    hyprctl keyword general:gaps_in "9"
    rm "$STATE_FILE"
else
    hyprctl keyword general:gaps_out "5,10,10,5"
    hyprctl keyword general:gaps_in "5"
    touch "$STATE_FILE"
fi
