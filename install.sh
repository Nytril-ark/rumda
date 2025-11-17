#!/bin/bash

# ============================================
# RUMDA DOTFILES INSTALLER (LIGHT)
# ============================================

# Theme Selection
THEME_CHOICE="light"  # Options: "light" or "pistachio"

# Installation Configuration (true/false)
# be aware that anything selected as true
# will overwrite the config files you have 
# at .config
#
#
DISABLE_BACKUP=false  # Set to true to skip backing up your current configs (NOT RECOMMENDED)
#
#


# (installs full thing but chadrc optional)
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
# # chadrc is defaulted as false so as not to 
# delete your own chadrc. if you don't care about that
# go ahead and set it to true. Not having my chadrc
# might make your theme look weird

# ============================================
# PATH CONFIGURATION
# ============================================

# Make sure you cloned rumda in 
# /home/.config/rumda
#
#
# DO NOT CHANGE THOSE AT ALL
SOURCE_DIR="$HOME/.config/rumda"
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
# THEME SELECTION
# ============================================

echo -e "${BOLD_YELLOW}"
echo "============================================"
echo "          RUMDA DOTFILES INSTALLER"
echo "============================================"
echo "      ／l、"
echo "    （ﾟ､ ｡ ７   a warmer, more cozy desktop.."
echo "      l  ~ヽ"
echo "      じしf_,)ノ"
echo "============================================"
echo -e "${NC}"

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "${RED}Error: Source directory not found at ${SOURCE_DIR}${NC}"
    echo -e "${YELLOW}Please clone the repository to ~/.config/rumda first${NC}"
    exit 1
fi

# Ask user which theme to install
echo -e "${CYAN}Which theme would you like to install?${NC}"
echo -e "${YELLOW}1) Rumda Light (recommended)${NC}"
echo -e "${MAGENTA}2) Rumda Pistachio${NC}"
echo ""
echo -e "${MAGENTA}NOTE: rumda-pistachio is unmaintained and doesn't recieve updates, sadly.${NC}"
echo ""
read -p "Enter choice (1 or 2, default: 1): " theme_input

case $theme_input in
    2)
        THEME_CHOICE="pistachio"
        ;;
    *)
        THEME_CHOICE="light"
        ;;
esac

# ============================================
# HANDLE PISTACHIO THEME
# ============================================

if [ "$THEME_CHOICE" = "pistachio" ]; then
    echo -e "${MAGENTA}Installing Rumda Pistachio...${NC}"
    
    # Check if pistachio subdirectory exists
    if [ ! -d "$SOURCE_DIR/rumda-pistachio" ]; then
        echo -e "${RED}Error: Pistachio theme not found at ${SOURCE_DIR}/rumda-pistachio${NC}"
        exit 1
    fi
    
    # Copy rumda-pistachio to .config/rumda-pistachio
    echo -e "${YELLOW}Copying Rumda Pistachio to ~/.config/rumda-pistachio...${NC}"
    
    if [ -d "$HOME/.config/rumda-pistachio" ]; then
        echo -e "${YELLOW}Removing existing rumda-pistachio directory...${NC}"
        rm -rf "$HOME/.config/rumda-pistachio"
    fi
    
    cp -r "$SOURCE_DIR/rumda-pistachio" "$HOME/.config/rumda-pistachio"
    
    # Make pistachio install script executable
    chmod +x "$HOME/.config/rumda-pistachio/install.sh"
    
    # Launch pistachio installer and disown
    echo -e "${MAGENTA}Launching Pistachio installer...${NC}"
    cd "$HOME/.config/rumda-pistachio"
    exec ./install.sh
    echo -e "${GREEN}Pistachio installer launched independently!${NC}"
    exit 0
fi

# ============================================
# CONTINUE WITH LIGHT THEME INSTALLATION
# ============================================

echo -e "${YELLOW}Installing Rumda Light...${NC}"
echo ""

# Git pull to get latest version
echo -e "${CYAN}Updating repository to latest version...${NC}"
cd "$SOURCE_DIR"

# Check if there are uncommitted changes
if git diff-index --quiet HEAD --; then
    # No local changes, safe to pull
    echo -e "${CYAN}Updating repository to latest version...${NC}"
    git pull origin main 2>/dev/null || git pull origin master 2>/dev/null
else
    # Has local changes, offer choice
    echo -e "${YELLOW}Warning: You have local changes in the repository.${NC}"
    echo -e "${CYAN}1) Keep local changes and skip update${NC}"
    echo -e "${CYAN}2) Discard local changes and update${NC}"
    read -p "Choice (1/2): " pull_choice
    
    case $pull_choice in
        2)
            echo -e "${RED}Discarding local changes...${NC}"
            git fetch origin
            git reset --hard origin/main 2>/dev/null || git reset --hard origin/master 2>/dev/null
            ;;
        *)
            echo -e "${YELLOW}Keeping local changes, skipping update...${NC}"
            ;;
    esac
fi

echo ""

echo -e "${YELLOW}Source directory: ${SOURCE_DIR}${NC}"
echo -e "${YELLOW}Destination directory: ${DEST_DIR}${NC}"
echo ""

echo -e "${CYAN}This will install the selected configs and backup existing ones.${NC}"
read -p "Continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}Installation cancelled.${NC}"
    exit 0
fi

# ============================================
# HELPER FUNCTION
# ============================================

install_config() {
    local source="$1"
    local dest="$2"
    local name="$3"
    
    echo -e "${YELLOW}Installing ${name}...${NC}"
    
    # Check if source exists
    if [ ! -d "$source" ] && [ ! -f "$source" ]; then
        echo -e "${RED}> Failed: Source not found at ${source}${NC}"
        echo -e "${RED}Are you sure you cloned to the right location? ${NC}"
        return 1
    fi
    
    # Create destination parent directory if it doesn't exist
    local dest_parent=$(dirname "$dest")
    mkdir -p "$dest_parent"
    
    # Backup existing config if it exists
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
    
    # If source is a directory, copy its contents (not the directory itself)
    if [ -d "$source" ]; then
        # Create destination directory
        mkdir -p "$dest"
        
        # Copy contents, not the folder itself
        if cp -r "$source/"* "$dest/" 2>/dev/null; then
            echo -e "${GREEN}> Successfully installed ${name} to ${dest}${NC}"
            return 0
        else
            echo -e "${RED}> Failed to install ${name}${NC}"
            return 1
        fi
    else
        # If source is a file, copy it directly
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

# Install nvim theme only NOTE: (without chadrc, it might not look as expected)
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



# Run the font install script
/home/$USER/.config/rumda/scripts/installFonts.sh
echo -e "${GREEN}> Successfully installed fonts to /usr/share/fonts"


echo -e "${YELLOW}Creating tinkerer flag file...${NC}"
echo "Hello Tinkerer. Do not delete this file. For more info, check the tinkerer.md file in this same directory." > "$HOME/.config/rumda/common/tinkerer/DoNotDeleteMe.txt"


echo ""
echo ""
echo -e "${GREEN}"
echo "============================================"
echo "          Installation Complete!"
echo "============================================"
echo "              へ    ╱|、"
echo "          ૮ -  ՛)  ('  -7"
echo "     乀 (ˍ, ل ل    じしˍ,)ノ"
echo ""
echo -e "${NC}"
echo -e "${YELLOW}Note: Original configs (if existent) were backed up with timestamp${NC}"
echo -e "${YELLOW}You may need to restart your session for changes to take effect${NC}"
echo ""

# Apply light theme
"$HOME/.config/rumda/scripts/hyprtheme.sh" light

killall quickshell 

ya pkg marcosvnmelo/kanagawa-dragon > /dev/null 2>&1

cd && quickshell -p .config/rumda/common/quickshell/shell.qml &disown
