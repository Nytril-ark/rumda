#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

COPR_REPOS=(
    "lionheartp/Hyprland"
    "lihaohong/yazi"
)

PACKAGES=(
    hyprland
    hyprland-guiutils
    hyprlock
    awww
    quickshell
    qt5-qtgraphicaleffects
    qt6-qt5compat
    mako
    rofi
    alacritty
    zathura
    zathura-pdf-mupdf
    yazi
    eza
    neovim
    tree-sitter-cli
    btop
    bpytop
    grim
    slurp
    swappy
    wl-clipboard
    wl-clip-persist
    cliphist
    firefox
    thunar
    adw-gtk3-theme
    papirus-icon-theme
    dconf
    nwg-look
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    qt5ct
    feh
    sensors
    yt-dlp
    tldr
    ffmpeg
    tesseract
    qt6ct
    google-noto-color-emoji-fonts
    google-noto-sans-arabic-fonts
    google-noto-naskh-arabic-fonts
    git
)

echo -e "${CYAN}Installing rumda packages...${NC}"

sudo dnf install dnf-plugins-core

for repo in "${COPR_REPOS[@]}"; do
    echo -e "${YELLOW}Enabling COPR ${repo}...${NC}"
    sudo dnf copr enable "$repo"
done

sudo dnf install --skip-unavailable "${PACKAGES[@]}"

# if ! command -v wl-clip-persist >/dev/null 2>&1 && command -v cargo >/dev/null 2>&1; then
#     cargo install wl-clip-persist
# fi

# if ! command -v cliphist >/dev/null 2>&1 && command -v go >/dev/null 2>&1; then
#     go install go.senan.xyz/cliphist@latest
# fi

missing=()
for pkg in "${PACKAGES[@]}"; do
    rpm -q "$pkg" >/dev/null 2>&1 || command -v "$pkg" >/dev/null 2>&1 || missing+=("$pkg")
done

if [ ${#missing[@]} -eq 0 ]; then
    echo -e "${GREEN}> All packages installed${NC}"
else
    echo -e "${RED}> Could not install: ${missing[*]}${NC}"
    echo -e "${YELLOW}Check the names with: dnf search <name>${NC}"
fi
