#!/bin/bash

# Downloading rust tools
echo ""
echo "Install Rust Tools? [y/n]"
read input
if [[ $input == "Y" || $input == "y" ]]; then 
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
echo ""
