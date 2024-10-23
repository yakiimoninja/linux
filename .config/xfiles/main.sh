#!/bin/bash

#https://www.atlassian.com/git/tutorials/dotfiles

# Making scripts executable
chmod -R +x scripts/

# Creating directories
./scripts/dirs.sh
########################################################

# Setting volume
./scripts/audio.sh

########################################################

# Setting mirrorlist
./scripts/mirrors.sh

########################################################

# Installing AUR helper YAY
./scripts/aur.sh

########################################################

# Recovering files from github
./scripts/dotfiles.sh

########################################################

# Downloading software
./scripts/packages.sh

########################################################

# Downloading rust tools
./scripts/dev.sh

########################################################

# Copying xfiles
./scripts/xfiles.sh

########################################################

# Disabling hibernation/sleep etc
./scripts/sleep.sh

########################################################

echo ""
echo "Done."
echo "Please reboot."
