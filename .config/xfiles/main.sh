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
    sudo pacman -Sy reflector --noconfirm
    sudo reflector --latest 20 --sort rate --save /etc/pacman.d/mirrorlist --protocol https --download-timeout 15
fi

# Installing AUR and YAY
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

# Downloading software
echo ""
echo "Install packages? [y/n]"
read input
if [[ $input == "Y" || $input == "y" ]]; then 
    # Xorg packages that may be needed: xlip libxft libxinerama flameshot discord redshift
    
    # Nvidia Drivers
    sudo pacman -Sy --noconfirm base-devel linux-headers nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings

    # Hyprland
    sudo pacman -Sy --noconfirm hyprland dunst dolphin wofi xdg-desktop-portal-hyprland qt5-wayland qt6-wayland polkit-kde-agent waybar

    # Staple packages
    sudo pacman -Sy --noconfirm neovim vi bash-completion steam alacritty keepassxc mpv archlinux-keyring adobe-source-han-sans-jp-fonts noto-fonts-emoji neofetch ranger dunst firefox unrar unzip xz lxappearance ueberzug openssh obs-studio htop p7zip ripgrep fuse lazygit udiskie

    ## AUR packages
    yay -Sy nsxiv game-devices-udev autojump webcord-git hyprshade
fi

# Recovering files from github
echo ""
echo "Recover dotfiles from github? [y/n]"
read input
if [[ $input == "Y" || $input == "y" ]]; then 
    mkdir $HOME/.dotfiles
    echo ".dotfiles" >> $HOME/.gitignore
    git clone --bare https://github.com/yakiimoninja/linux $HOME/.dotfiles
    rm .bashrc
    rm .bash_profile
    /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout
    /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME push --set-upstream origin main
    echo -e "[status]\n\tshowUntrackedFiles = no" >> $HOME/.dotfiles/config
    source $HOME/.bashrc

    # Seperate nvim config
    git clone https://github.com/yakiimoninja/nvim $HOME/.config/
    
    # Fixing nitrogen bg paths
    user=$(whoami)
    sed -i "s/user_name/$user/g" "$HOME//.config/nitrogen/bg-saved.cfg"
    sed -i "s/user_name/$user/g" "$HOME//.config/nitrogen/nitrogen.cfg"
    sed -i "s/user_name/$user/g" "$HOME//.gtkrc-2.0"
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
    sudo cp $HOME/.config/xfiles/grub /etc/default/
    sudo cp $HOME/.config/xfiles/xorg.conf /etc/X11/
    sudo cp $HOME/.config/xfiles/sudoers /etc/
    sudo cp $HOME/.config/xfiles/pgame /bin/
    sudo cp $HOME/.config/xfiles/pstart /bin/
    sudo cp $HOME/.config/xfiles/pstop /bin/
fi

# Compiling suckless software
echo ""
echo "Compile suckless software? [y/n]"
read input
if [[ $input == "Y" || $input == "y" ]]; then
    # Making reboot and shutdown available from dmenu
    sudo chmod a+s /sbin/shutdown
    sudo chmod a+s /sbin/reboot
    
    # Removes old dwm config
    rm $HOME/.config/suckless/dwm/config.h


    
    cd $HOME/.config/suckless/dmenu
    sudo make clean install $HOME/.config/suckless/dmenu
    cd $HOME/.config/suckless/dwm
    sudo make clean install $HOME/.config/suckless/dwm
    cd $HOME/.config/suckless/slock
    sudo make clean install $HOME/.config/suckless/slock
    cd $HOME/.config/suckless/slstatus
    sudo make clean install $HOME/.config/suckless/slstatus
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
