#!/bin/bash

# Creating directories
echo ""
echo "Checking for home directories."
echo ""

if [[ ! -d "$HOME/documents" && ! -d "$HOME/Documents" ]]; then
    echo "Creating documents directory."
    mkdir $HOME/Documents
else
    echo "Documents directory exists."
fi

if [[ ! -d "$HOME/downloads" && ! -d "$HOME/Downloads" ]]; then
    echo "Creating downloads directory."
    mkdir $HOME/Downloads 
else
    echo "Downloads directory exists."
fi

if [[ ! -d "$HOME/pictures" && ! -d "$HOME/Pictures" ]]; then 
        echo "Creating pictures directory."
        mkdir $HOME/Pictures
else
    echo "Pictures directory exists."
fi

if [[ ! -d "$HOME/videos" && ! -d "$HOME/Videos" ]]; then
    echo "Creating videos directory."
    mkdir $HOME/Videos 
else
    echo "Videos directory exists."
fi

if [[ ! -d "$HOME/music" && ! -d "$HOME/Music" ]]; then
    echo "Creating music directory."
    mkdir $HOME/Music 
else
    echo "Music directory exists."
fi

if [[ ! -d "$HOME/dev" && ! -d "$HOME/Dev" ]]; then
    echo "Creating Dev directory."
    mkdir $HOME/dev
else
    echo "Dev directory exists."
fi
