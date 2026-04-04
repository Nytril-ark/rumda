#!/bin/bash
STATE_FILE="/tmp/hypr_gaps_lolz"
if [ -f "$STATE_FILE" ]; then
    hyprctl keyword general:gaps_out "45,40,45,40"
    hyprctl keyword general:gaps_in "9"
    hyprctl keyword decoration:shadow:enabled true
    rm "$STATE_FILE"
else
    hyprctl keyword general:gaps_out "5,5,5,13"
    hyprctl keyword general:gaps_in "1"
    hyprctl keyword decoration:shadow:enabled false
    touch "$STATE_FILE"
fi
