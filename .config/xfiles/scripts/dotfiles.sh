#!/bin/bash

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
    echo ""
    echo "Recover nvim dotfiles from github? [y/n]"
    read input
    if [[ $input == "Y" || $input == "y" ]]; then
        git clone https://github.com/yakiimoninja/nvim $HOME/.config/
    fi
fi
echo ""
