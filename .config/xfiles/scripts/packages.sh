#!/bin/bash

# Downloading software
echo ""
echo "Install packages? [y/n]"
read input
if [[ $input == "Y" || $input == "y" ]]; then 
    # Xorg packages that may be needed: xlip libxft libxinerama flameshot discord redshift
    
    # Updating keyrings
    sudo pacman -Sy --noconfirm archlinux-keyring
    
    # Nvidia Drivers
    echo ""
    echo "Install Nvidia drivers? [y/n]"
    read input
    echo ""
    if [[ $input == "Y" || $input == "y" ]]; then
        sudo pacman -Sy --noconfirm --needed - < $HOME/.config/xfiles/pkgs/pkgs_nvidia.txt
    fi
    echo ""
    
    # Hyprland
    sudo pacman -S --noconfirm --needed - < $HOME/.config/xfiles/pkgs/pkgs_hyprland.txt
    
    # Staple packages
    sudo pacman -S --noconfirm --needed - < $HOME/.config/xfiles/pkgs/staple.txt
    
    ## AUR packages
    yay -Sy --noconfirm --needed - < $HOME/.config/xfiles/pkgs/pkgs_aur.txt
fi
echo ""
