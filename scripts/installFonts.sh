#!/bin/bash

echo "Copying fonts to ~/.local/share/fonts."
echo ""
mkdir -p ~/.local/share/fonts
cp -r /home/$USER/.config/rumda/common/fonts/* ~/.local/share/fonts

fc-cache -fv > /dev/null

