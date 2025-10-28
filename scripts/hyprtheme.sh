
#!/bin/bash
# usage: hyprtheme [light|dark]

set -e
THEME="$1"

case "$THEME" in
  light)
    echo "Switching to LIGHT theme..."

    # General border colors
    hyprctl keyword general:col.active_border "rgba(D1AB86FF)" >/dev/null
    hyprctl keyword general:col.inactive_border "rgba(D1AB86AA)" >/dev/null

    # Borders-plus-plus plugin
    hyprctl keyword plugin:borders-plus-plus:col.border_1 "rgb(D5CCBA)" >/dev/null
    hyprctl keyword plugin:borders-plus-plus:col.border_2 "rgb(2A1F18)" >/dev/null
    hyprctl keyword plugin:borders-plus-plus:natural_rounding "yes" >/dev/null
    ;;
    
  dark)
    echo "🌙 Switching to DARK theme..."

    # General border colors
    hyprctl keyword general:col.active_border "rgba(D1AB86FF)" >/dev/null
    hyprctl keyword general:col.inactive_border "rgba(D1AB86AA)" >/dev/null

    # Borders-plus-plus plugin
    hyprctl keyword plugin:borders-plus-plus:col.border_1 "rgb(D5CCBA)" >/dev/null
    hyprctl keyword plugin:borders-plus-plus:col.border_2 "rgb(3A2D26)" >/dev/null
    hyprctl keyword plugin:borders-plus-plus:natural_rounding "2" >/dev/null
    ;;
    
  *)
    echo "Usage: $0 [light|dark]"
    exit 1
    ;;
esac

echo "✅ Switched Hyprland theme to '$THEME'"



