#!/bin/bash

#https://www.atlassian.com/git/tutorials/dotfiles

# Creating directories
echo ""
echo "Checking for home directories."
echo ""

if [[ ! -d "$HOME/documents" && ! -d "$HOME/Documents" ]]; then
    echo "Creating documents folder."
    mkdir $HOME/Documents
else
    echo "Documents folder exists."
fi

if [[ ! -d "$HOME/downloads" && ! -d "$HOME/Downloads" ]]; then
    echo "Creating downloads folder."
    mkdir $HOME/Downloads 
else
    echo "Downloads folder exists."
fi

if [[ ! -d "$HOME/pictures" && ! -d "$HOME/Pictures" ]]; then 
        echo "Creating pictures folder."
        mkdir $HOME/Pictures
else
    echo "Pictures folder exists."
fi

if [[ ! -d "$HOME/videos" && ! -d "$HOME/Videos" ]]; then
    echo "Creating videos folder."
    mkdir $HOME/Videos 
else
    echo "Videos folder exists."
fi

if [[ ! -d "$HOME/music" && ! -d "$HOME/Music" ]]; then
    echo "Creating music folder."
    mkdir $HOME/Music 
else
    echo "Music folder exists."
fi

if [[ ! -d "$HOME/code" && ! -d "$HOME/Code" ]]; then
    echo "Creating code folder."
    mkdir $HOME/code 
else
    echo "Code folder exists."
fi
    
# Setting volume
echo ""
echo "Set volume to 0.70."
wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.70

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

# Recovering files from github
echo ""
echo "Recover dotfiles from github? [y/n]"
read input
if [[ $input == "Y" || $input == "y" ]]; then 
    mkdir $HOME/.dotfiles
    echo ".dotfiles" >> $HOME/.gitignore
    git clone --bare --branch hyprland --single-branch https://github.com/yakiimoninja/linux $HOME/.dotfiles
    rm .bashrc
    rm .bash_profile
    /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout
    /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME push --set-upstream origin hyprland
    echo -e "[status]\n\tshowUntrackedFiles = no" >> $HOME/.dotfiles/config
    source $HOME/.bashrc

    # Seperate nvim config
    git clone https://github.com/yakiimoninja/nvim $HOME/.config/
fi

# Downloading software
echo ""
echo "Install packages? [y/n]"
read input
if [[ $input == "Y" || $input == "y" ]]; then 
    # Xorg packages that may be needed: xlip libxft libxinerama flameshot discord redshift
    
    # Updating keyrings
    sudo pacman -Sy --noconfirm archlinux-keyring
    # Nvidiscorda Drivers
    sudo pacman -Sy --noconfirm --needed - < $HOME/.config/xfiles/pkgs/pkgs_nvidia.txt
    # Hyprland
    sudo pacman -S --noconfirm --needed - < $HOME/.config/xfiles/pkgs/pkgs_hyprland.txt
    # Staple packages
    sudo pacman -S --noconfirm --needed - < $HOME/.config/xfiles/pkgs/staple.txt
    
    ## AUR packages
    yay -Sy --noconfirm --needed - < $HOME/.config/xfiles/pkgs/pkgs_aur.txt
fi

# Downloading rust tools
echo ""
echo "Install Rust Tools? [y/n]"
read input
if [[ $input == "Y" || $input == "y" ]]; then 
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

# Copying xfiles
echo ""
echo "Copy system conf files? [y/n]"
read input
if [[ $input == "Y" || $input == "y" ]]; then 
    sudo cp $HOME/.config/xfiles/00-keyboard.conf /etc/X11/xorg.conf.d/
    sudo cp $HOME/.config/xfiles/50-mouse-acceleration.conf /etc/X11/xorg.conf.d/
    sudo cp $HOME/.config/xfiles/blacklist.conf /etc/modprobe.d/
    sudo cp $HOME/.config/xfiles/xorg.conf /etc/X11/
    sudo cp $HOME/.config/xfiles/sudoers /etc/
    sudo cp $HOME/.config/xfiles/pgame /bin/
    sudo cp $HOME/.config/xfiles/pstart /bin/
    sudo cp $HOME/.config/xfiles/pstop /bin/
    
    # Nvidia Hyprland
    sudo cp $HOME/.config/xfiles/mkinitcpio.conf /etc/mkinitcpio.conf
    sudo cp $HOME/.config/xfiles/grub /etc/default/
    sudo cp $HOME/.config/xfiles/nvidia.conf /etc/modprobe.d/nvidia.conf

    echo ""
    echo "Making grub config."
    sudo grub-mkconfig -o /boot/grub/grub.cfg
    
    echo ""
    echo "Making mkinitcpio config."
    sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img
    
fi

# Disabling hibernation/sleep etc
echo ""
echo "Disable hibernation/sleep etc.? [y/n]"
read input
if [[ $input == "Y" || $input == "y" ]]; then 
    sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
fi

echo ""
echo "Done."
echo "Please reboot."
# Uncomment to enable hibernation/sleep etc
#sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target
