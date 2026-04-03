#!/bin/bash
# usage: hyprtheme light / hyprtheme dark

set -e

THEME="$1"
RUMDA_DIR="$HOME/.config/rumda"
TINKERER_FLAG="$HOME/.config/rumda/common/tinkerer/DoNotDeleteMe.txt"
TINKERER_MD="$HOME/.config/rumda/common/tinkerer/tinkerer.md"
COMMON_FILE="$HOME/.config/hypr/hyprland.conf"


if [[ ! -f "$TINKERER_FLAG" ]]; then
    echo "Creating backup of your configs..."
    echo "Hello Tinkerer. Do not delete this file. For more info, check the tinkerer.md file in this same directory." > "$TINKERER_FLAG"
    
    backup_config() {
        local config_path="$1"
        local config_name="$2"
        
        if [[ -e "$config_path" ]]; then
            local backup_name="${config_path}.tinkerer-backup.$(date +%Y%m%d_%H%M%S)"
            echo "  Backing up $config_name to $backup_name"
            cp -r "$config_path" "$backup_name"
        fi
    }
    
    backup_config "$HOME/.config/hypr/hyprland.conf" "Hyprland"
    backup_config "$HOME/.config/alacritty/alacritty.toml" "Alacritty"
    backup_config "$HOME/.config/yazi/theme.toml" "Yazi"
    backup_config "$HOME/.config/zathura/zathurarc" "Zathura"
    backup_config "$HOME/.config/mako/config" "Mako"
    backup_config "$HOME/.config/hypr/hyprlock.conf" "Hyprlock"
    
    echo "Backups created successfully!"
    
    notify-send "Rumda:" "If you are seeing this then you didnt use the install script. Dont worry though. Your configs have been backed up." &
    
    open_editor() {
        nohup "$@" > /dev/null 2>&1 &
        disown
    }

    if command -v nvim &> /dev/null && command -v alacritty &> /dev/null; then
        open_editor alacritty -e nvim "$TINKERER_MD"
    elif command -v nvim &> /dev/null && command -v ghostty &> /dev/null; then
        open_editor ghostty -e nvim "$TINKERER_MD"
    elif command -v nvim &> /dev/null && command -v kitty &> /dev/null; then
        open_editor kitty -e nvim "$TINKERER_MD"
    elif command -v vim &> /dev/null && command -v alacritty &> /dev/null; then
        open_editor alacritty -e vim "$TINKERER_MD"
    elif command -v nano &> /dev/null && command -v alacritty &> /dev/null; then
        open_editor alacritty -e nano "$TINKERER_MD"
    elif command -v xdg-open &> /dev/null; then
        open_editor xdg-open "$TINKERER_MD"
    fi
    
    sleep 2
fi







# =====================================================================================

case "$THEME" in
  light)
    SRC="$RUMDA_DIR/light-config/hypr/hyprland.conf"
    ;;
  dark)
    SRC="$RUMDA_DIR/dark-config/hypr/hyprland.conf"
    ;;
  *)
    echo "Usage: $0 [light|dark]"
    exit 1
    ;;
esac

if [[ ! -f "$SRC" ]]; then
  echo "Theme config not found at: $SRC"
  exit 1
fi

sleep 0.9
rm -f "$COMMON_FILE"
ln -fs "$SRC" "$COMMON_FILE"

/home/$USER/.config/rumda/scripts/alacrittytheme.sh "$THEME"
/home/$USER/.config/rumda/scripts/yazitheme.sh "$THEME"
/home/$USER/.config/rumda/scripts/zathuratheme.sh "$THEME"
/home/$USER/.config/rumda/scripts/makotheme.sh "$THEME"
/home/$USER/.config/rumda/scripts/locktheme.sh "$THEME"

notify-send "Rumda:" "switched to '$THEME' theme" &

hyprctl reload >/dev/null 2>&1 || true

echo "Switched to '$THEME' theme"

