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






# # #####################################################################################
# # ### FRESH SYSTEM - (dependencies included)
# # #
# # # Updating and loading repositories:
# # #  Fedora 44 openh264 (From Cisco) - x86_ 100% |   1.7 KiB/s |   5.3 KiB |  00m03s
# # #  Copr repo for Hyprland owned by lionhe 100% |  40.4 KiB/s | 154.6 KiB |  00m04s
# # #  Copr repo for yazi owned by lihaohong  100% | 884.0   B/s |   3.3 KiB |  00m04s
# # #  Fedora 44 - x86_64 - Updates           100% |   1.9 MiB/s |  11.9 MiB |  00m06s
# # #  Fedora 44 - x86_64                     100% |   1.8 MiB/s |  36.7 MiB |  00m20s
# # # Repositories loaded.
# # # No match for argument: bpytop
# # # No match for argument: wl-clip-persist
# # #
# # # Total size of inbound packages is 962 MiB. Need to download 962 MiB.
# # # After this operation, 3 GiB extra will be used (install 3 GiB, remove 0 B).
# # # Operation aborted by the user.
# # #  xdriinfo                      x86_64 0:1.0.7-6.fc44        fedora      29.7 KiB
# # #  xfsprogs                      x86_64 0:7.1.1-1.fc44        updates      4.3 MiB
# # #  xsel                          x86_64 0:1.2.1-10.fc44       fedora      47.5 KiB
# # #  zoxide                        x86_64 0:0.9.8-2.fc44        fedora       1.2 MiB
# # #
# # # Transaction Summary:
# # #  Installing:       899 packages
# # #
# # # ###################################################################################
# # #  Packages only without dependecies: 
# # # git                                          0.1 MB
# # # eza                                          2.0 MB
# # # neovim                                      33.1 MB
# # # wl-clipboard                                 0.1 MB
# # # tree-sitter-cli                              7.1 MB
# # # btop                                         1.8 MB
# # # alacritty                                    7.5 MB
# # # slurp                                        0.0 MB
# # # grim                                         0.0 MB
# # # zathura                                      1.8 MB
# # # xdg-desktop-portal-gtk                       0.5 MB
# # # swappy                                       0.1 MB
# # # dconf                                        0.3 MB
# # # hyprland                                    66.2 MB
# # # xdg-desktop-portal-hyprland                  1.0 MB
# # # hyprland-guiutils                            0.8 MB
# # # firefox                                    289.1 MB
# # # rofi                                         0.7 MB
# # # awww                                         8.9 MB
# # # quickshell                                   7.1 MB
# # # qt5-qtgraphicaleffects                       0.6 MB
# # # qt6-qt5compat                                2.1 MB
# # # google-noto-color-emoji-fonts                4.6 MB
# # # feh                                          0.4 MB
# # # yt-dlp                                      21.0 MB
# # # tldr                                         0.1 MB
# # # yazi                                        40.6 MB
# # # google-noto-naskh-arabic-fonts               1.0 MB
# # # google-noto-sans-arabic-fonts                8.3 MB
# # # zathura-pdf-mupdf                            0.0 MB
# # # hyprlock                                     1.0 MB
# # # mako                                         0.1 MB
# # # tesseract                                    0.1 MB
# # # Thunar                                      10.7 MB
# # # qt5ct                                        0.9 MB
# # # qt6ct                                        0.7 MB
# # # adw-gtk3-theme                               1.0 MB
# # # papirus-icon-theme                         102.8 MB
# # # nwg-look                                     4.9 MB
# # # cliphist                                     2.5 MB
# # # TOTAL: 631.7 MB
# ###################################################################################
