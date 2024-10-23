#!/bin/bash

# Copying xfiles
echo ""
echo "Copy system conf files? [y/n]"
read input
if [[ $input == "Y" || $input == "y" ]]; then 
    sudo cp $HOME/.config/xfiles/configs/00-keyboard.conf /etc/X11/xorg.conf.d/
    sudo cp $HOME/.config/xfiles/configs/50-mouse-acceleration.conf /etc/X11/xorg.conf.d/
    sudo cp $HOME/.config/xfiles/configs/blacklist.conf /etc/modprobe.d/
    sudo cp $HOME/.config/xfiles/configs/xorg.conf /etc/X11/
    sudo cp $HOME/.config/xfiles/configs/sudoers /etc/
    sudo cp $HOME/.config/xfiles/scripts/pgame /bin/
    sudo cp $HOME/.config/xfiles/scripts/pstart /bin/
    sudo cp $HOME/.config/xfiles/scripts/pstop /bin/
    
    # Nvidia Hyprland
    sudo cp $HOME/.config/xfiles/configs/mkinitcpio.conf /etc/mkinitcpio.conf
    sudo cp $HOME/.config/xfiles/configs/grub /etc/default/
    sudo cp $HOME/.config/xfiles/configs/nvidia.conf /etc/modprobe.d/nvidia.conf

    echo ""
    echo "Making grub config."
    sudo grub-mkconfig -o /boot/grub/grub.cfg
    
    echo ""
    echo "Making mkinitcpio config."
    sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img
    
fi
echo ""
