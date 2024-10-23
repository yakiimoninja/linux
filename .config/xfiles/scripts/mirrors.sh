#!/bin/bash

# Setting mirrorlist
echo ""
echo "Install and sort mirrorlist with reflector? [y/n]"
read input
if [[ $input == "Y" || $input == "y" ]]; then
    # Updating keyrings
    sudo pacman -Sy --noconfirm archlinux-keyring
    sudo pacman -Sy reflector --noconfirm
    sudo reflector --latest 20 --sort rate --save /etc/pacman.d/mirrorlist --protocol https --download-timeout 15
fi
echo ""
