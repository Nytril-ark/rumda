# #!/bin/bash
# # ============================================
# # RUMDA DOTFILES INSTALLER
# # ============================================
# # Installation Configuration (true/false)
# # be aware that anything selected as true
# # will overwrite the config files you have 
# # at .config
# INSTALL_HYPRLAND=true
# INSTALL_QUICKSHELL=true
# INSTALL_ALACRITTY=true
# INSTALL_GHOSTTY=true
# INSTALL_ZATHURA=true
# INSTALL_ROFI=true
# INSTALL_BPYTOP=true
# INSTALL_BTOP=true
# INSTALL_YAZI=true
# INSTALL_NEOFETCH=true
# INSTALL_NEOTHEME=true
# INSTALL_CHADRC=false # this is defaulted as false so as not to 
# # delete your own chadrc. if you don't care about that
# # go ahead and set it to true. Not having my chadrc
# # might make your theme look weird
#
#
# # ============================================
# # PATH CONFIGURATION
# # ============================================
# # Make sure you cloned rumda in 
# # /home/.config/rumda
# SOURCE_DIR="$HOME/.config/rumda"
#
# DEST_DIR="$HOME/.config"
#
# # ============================================
# # COLORS
# # ============================================
# GREEN='\033[0;32m'
# RED='\033[0;31m'
# YELLOW='\033[1;33m'
# BOLD_YELLOW='\033[1;33m'
# CYAN='\033[0;36m'
# NC='\033[0m' 
# # ============================================
# # HELPER FUNCTIONS
# # ============================================
#
# # Function to copy config with error checking
# install_config() {
#     local source="$1"
#     local dest="$2"
#     local name="$3"
#
#     echo -e "${YELLOW}Installing ${name}...${NC}"
#
#     # Check if source exists
#     if [ ! -d "$source" ] && [ ! -f "$source" ]; then
#         echo -e "${RED}> Failed: Source not found at ${source}${NC}"
#         echo -e "${RED}Are you sure you cloned to the right location? ${NC}"
#         return 1
#     fi
#
#     # Create destination parent directory if it doesn't exist
#     local dest_parent=$(dirname "$dest")
#     mkdir -p "$dest_parent"
#
#     # Backup existing config if it exists
#     if [ -e "$dest" ]; then
#         echo -e "${YELLOW}  Backing up existing config to ${dest}.backup${NC}"
#         mv "$dest" "${dest}.backup"
#     fi
#
#     # Copy the config
#     if cp -r "$source" "$dest"; then
#         echo -e "${GREEN}> Successfully installed ${name} to ${dest}${NC}"
#         return 0
#     else
#         echo -e "${RED}> Failed to install ${name}${NC}"
#         return 1
#     fi
# }
#
# # ============================================
# # MAIN INSTALLATION
# # ============================================
#
# echo -e "${BOLD_YELLOW}"
# echo "============================================"
# echo "          RUMDA DOTFILES INSTALLER"
# echo "============================================"
# echo "      ／l、"
# echo "    （ﾟ､ ｡ ７   a warmer, more cozy desktop.."
# echo "      l  ~ヽ"
# echo "      じしf_,)ノ"
# echo "============================================"
# echo -e "${NC}"
#
# # Check if source directory exists
# if [ ! -d "$SOURCE_DIR" ]; then
#     echo -e "${RED}Error: Source directory not found at ${SOURCE_DIR}${NC}"
#     echo -e "${YELLOW}Please clone the repository to ~/.config/rumda first${NC}"
#     exit 1
# fi
#
# echo -e "${YELLOW}Source directory: ${SOURCE_DIR}${NC}"
# echo -e "${YELLOW}Destination directory: ${DEST_DIR}${NC}"
# echo ""
#
# # Install Hyprland
# if [ "$INSTALL_HYPRLAND" = true ]; then
#     install_config "$SOURCE_DIR/common/hypr" "$DEST_DIR/hypr" "Hyprland"
# fi
#
# # Install Quickshell
# if [ "$INSTALL_QUICKSHELL" = true ]; then
#     install_config "$SOURCE_DIR/common/quickshell" "$DEST_DIR/quickshell" "Quickshell"
# fi
#
# # Install Alacritty
# if [ "$INSTALL_ALACRITTY" = true ]; then
#     install_config "$SOURCE_DIR/light-config/alacritty" "$DEST_DIR/alacritty" "Alacritty"
# fi
#
# # Install Ghostty
# if [ "$INSTALL_GHOSTTY" = true ]; then
#     install_config "$SOURCE_DIR/light-config/ghostty" "$DEST_DIR/ghostty" "Ghostty"
# fi
#
# # Install ZATHURA
# if [ "$INSTALL_ZATHURA" = true ]; then
#     install_config "$SOURCE_DIR/light-config/zathura" "$DEST_DIR/zathura" "Zathura"
# fi
#
# # Install Rofi
# if [ "$INSTALL_ROFI" = true ]; then
#     install_config "$SOURCE_DIR/light-config/rofi" "$DEST_DIR/rofi" "Rofi"
# fi
#
# # Install bpytop
# if [ "$INSTALL_BPYTOP" = true ]; then
#     install_config "$SOURCE_DIR/light-config/bpytop" "$DEST_DIR/bpytop" "Bpytop"
# fi
#
# # Install btop
# if [ "$INSTALL_BTOP" = true ]; then
#     install_config "$SOURCE_DIR/light-config/btop" "$DEST_DIR/btop" "Btop"
# fi
#
# # Install yazi
# if [ "$INSTALL_YAZI" = true ]; then
#     install_config "$SOURCE_DIR/light-config/yazi" "$DEST_DIR/yazi" "Yazi"
# fi
#
# # Install neofetch
# if [ "$INSTALL_NEOFETCH" = true ]; then
#     install_config "$SOURCE_DIR/common/neofetch" "$DEST_DIR/neofetch" "Neofetch"
# fi
#
# # Install nvim theme only NOTE: (without chadrc, it might not look as expected)
# if [ "$INSTALL_NEOTHEME" = true ]; then
#     install_config "$SOURCE_DIR/common/nvim/lua/themes" "$DEST_DIR/nvim/lua/themes" "editor_theme"
# fi
#
# # Install chadrc 
# if [ "$INSTALL_CHADRC" = true ]; then
#     install_config "$SOURCE_DIR/common/nvim/lua/chadrc.lua" "$DEST_DIR/nvim/lua/" "chadrc"
# fi
#
#
# # ============================================
# # COMPLETION
# # ============================================
#
# echo ""
# echo -e "${GREEN}"
# echo "============================================"
# echo "          Installation Complete!"
# echo "============================================"
# echo "              へ    ╱|、"
# echo "          ૮ -  ՛)  ('  -7"
# echo "     乀 (ˍ, ل ل    じしˍ,)ノ"
# echo ""
# echo -e "${NC}"
# echo -e "${YELLOW}Note: Original configs (if existent) were backed up with .backup extension${NC}"
# echo -e "${YELLOW}You may need to restart your session for changes to take effect${NC}"
# echo ""

