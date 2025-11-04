#!/bin/bash

# ============================================
# RUMDA PISTACHIO INSTALLER
# ============================================

# Wait for parent process to finish
sleep 0.8

# Installation Configuration (true/false)
DISABLE_BACKUP=false   #  (it is not recommended to disable backup)

# Same configuration as light theme
INSTALL_HYPRLAND=true
INSTALL_QUICKSHELL=true
INSTALL_ALACRITTY=true
INSTALL_ZATHURA=true
INSTALL_ROFI=true
INSTALL_BPYTOP=true
INSTALL_BTOP=true
INSTALL_YAZI=true
INSTALL_NEOFETCH=true
INSTALL_NEOTHEME=true
INSTALL_GHOSTTY=true
INSTALL_DISCORD=true
INSTALL_CHADRC=false

# ============================================
# PATH CONFIGURATION
# ============================================

# DO NOT CHANGE THOSE AT ALL
SOURCE_DIR="$HOME/.config/rumda-pistachio"
DEST_DIR="$HOME/.config"

# ============================================
# COLORS
# ============================================

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BOLD_YELLOW='\033[1;33m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m'

# ============================================
# DELETE RUMDA LIGHT
# ============================================

echo -e "${MAGENTA}"
echo "============================================"
echo "       RUMDA PISTACHIO INSTALLER"
echo "============================================"
echo "      ／l、"
echo "    （˘､ ｡ ７   switching to pistachio..."
echo "      l  ~ヽ"
echo "      じしf_,)ノ"
echo "============================================"
echo -e "${NC}"

# Remove rumda-light directory (we're now independent)
if [ -d "$HOME/.config/rumda" ]; then
    echo -e "${YELLOW}Removing Rumda Light directory...${NC}"
    rm -r "$HOME/.config/rumda"
    echo -e "${GREEN}Rumda Light removed successfully!${NC}"
fi

echo ""
echo -e "${YELLOW}Source directory: ${SOURCE_DIR}${NC}"
echo -e "${YELLOW}Destination directory: ${DEST_DIR}${NC}"
echo ""

# ============================================
# HELPER FUNCTIONS
# ============================================

install_config() {
    local source="$1"
    local dest="$2"
    local name="$3"
    
    echo -e "${YELLOW}Installing ${name}...${NC}"
    
    if [ ! -d "$source" ] && [ ! -f "$source" ]; then
        echo -e "${RED}> Failed: Source not found at ${source}${NC}"
        return 1
    fi
    
    local dest_parent=$(dirname "$dest")
    mkdir -p "$dest_parent"
    
    if [ -e "$dest" ]; then
        if [ "$DISABLE_BACKUP" = false ]; then
            local backup_name="${dest}.backup.$(date +%Y%m%d_%H%M%S)"
            echo -e "${YELLOW}  Backing up existing config to ${backup_name}${NC}"
            mv "$dest" "$backup_name"
        else
            echo -e "${RED}  Removing existing config (backup disabled)${NC}"
            rm -rf "$dest"
        fi
    fi
    
    if [ -d "$source" ]; then
        mkdir -p "$dest"
        
        if cp -r "$source/"* "$dest/" 2>/dev/null; then
            echo -e "${GREEN}> Successfully installed ${name} to ${dest}${NC}"
            return 0
        else
            echo -e "${RED}> Failed to install ${name}${NC}"
            return 1
        fi
    else
        if cp "$source" "$dest"; then
            echo -e "${GREEN}> Successfully installed ${name} to ${dest}${NC}"
            return 0
        else
            echo -e "${RED}> Failed to install ${name}${NC}"
            return 1
        fi
    fi
}

# ============================================
# MAIN INSTALLATION
# ============================================

# Install Hyprland
if [ "$INSTALL_HYPRLAND" = true ]; then
    install_config "$SOURCE_DIR/light-config/hypr" "$DEST_DIR/hypr" "Hyprland"
fi

# Install Quickshell
if [ "$INSTALL_QUICKSHELL" = true ]; then
    install_config "$SOURCE_DIR/common/quickshell" "$DEST_DIR/quickshell" "Quickshell"
fi

# Install Alacritty
if [ "$INSTALL_ALACRITTY" = true ]; then
    install_config "$SOURCE_DIR/light-config/alacritty" "$DEST_DIR/alacritty" "Alacritty"
fi

# Install Ghostty
if [ "$INSTALL_GHOSTTY" = true ]; then
    install_config "$SOURCE_DIR/light-config/ghostty" "$DEST_DIR/ghostty" "Ghostty"
fi

# Install ZATHURA
if [ "$INSTALL_ZATHURA" = true ]; then
    install_config "$SOURCE_DIR/light-config/zathura" "$DEST_DIR/zathura" "Zathura"
fi

# Install Rofi
if [ "$INSTALL_ROFI" = true ]; then
    install_config "$SOURCE_DIR/light-config/rofi" "$DEST_DIR/rofi" "Rofi"
fi

# Install bpytop
if [ "$INSTALL_BPYTOP" = true ]; then
    install_config "$SOURCE_DIR/common/bpytop" "$DEST_DIR/bpytop" "Bpytop"
fi

# Install btop
if [ "$INSTALL_BTOP" = true ]; then
    install_config "$SOURCE_DIR/light-config/btop" "$DEST_DIR/btop" "Btop"
fi

# Install yazi
if [ "$INSTALL_YAZI" = true ]; then
    install_config "$SOURCE_DIR/light-config/yazi" "$DEST_DIR/yazi" "Yazi"
fi

# Install neofetch
if [ "$INSTALL_NEOFETCH" = true ]; then
    install_config "$SOURCE_DIR/common/neofetch" "$DEST_DIR/neofetch" "Neofetch"
fi

# Install nvim theme only
if [ "$INSTALL_NEOTHEME" = true ]; then
    install_config "$SOURCE_DIR/common/nvim/lua/themes" "$DEST_DIR/nvim/lua/themes" "editor_theme"
fi

# Install discord theme
if [ "$INSTALL_DISCORD" = true ]; then
    install_config "$SOURCE_DIR/common/vencord" "$DEST_DIR/Vencord/themes" "discord_theme"
fi

# Install chadrc
if [ "$INSTALL_CHADRC" = true ]; then
    install_config "$SOURCE_DIR/common/nvim/lua/chadrc.lua" "$DEST_DIR/nvim/lua/chadrc.lua" "chadrc"
fi

echo ""
echo -e "${MAGENTA}"
echo "============================================"
echo "    Pistachio Installation Complete!"
echo "============================================"
echo "              へ    ╱|、"
echo "          ૮ -  ՛)  ('  -7"
echo "     乀 (ˍ, ل ل    じしˍ,)ノ"
echo ""
echo -e "${NC}"
echo -e "${YELLOW}Note: Original configs were backed up with timestamp${NC}"
echo -e "${YELLOW}You may need to restart your session for changes to take effect${NC}"
echo ""

if [ -f "$HOME/.config/rumda-pistachio/scripts/hyprtheme.sh" ]; then
    "$HOME/.config/rumda-pistachio/scripts/hyprtheme.sh" light
fi

killall quickshell

cd && quickshell -p .config/rumda/common/quickshell/shell.qml &disown
