#!/bin/bash

# Disabling hibernation/sleep etc
echo ""
echo "Disable hibernation/sleep etc.? [y/n]"
read input
if [[ $input == "Y" || $input == "y" ]]; then 
    sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
fi
echo ""
# Uncomment to enable hibernation/sleep etc
#sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target
