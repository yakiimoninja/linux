#!/bin/bash

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
