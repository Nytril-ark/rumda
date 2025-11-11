#!/bin/bash

echo "Copying fonts to /usr/share/fonts.."
echo ""

sudo cp -r /home/$USER/.config/rumda/common/fonts/* /usr/share/fonts

fc-cache -fv > /dev/null

