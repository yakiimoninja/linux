#!/bin/bash

# Installing AUR helper YAY
echo ""
echo "Enable AUR and download YAY [y/n]"
read input
if [[ $input == "Y" || $input == "y" ]]; then
    git clone https://aur.archlinux.org/yay-bin.git /tmp/yay
    cd /tmp/yay/
    makepkg -si
    cd $HOME
    rm -rf /tmp/yay/
fi
echo ""
