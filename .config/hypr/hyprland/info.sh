#!/bin/sh

# Hyprland device type config loader

type="$(hostnamectl chassis)"
file=~/.config/hypr/hyprland/info.conf


if [[ -f $file ]]; then
    rm $file
fi


if [[ $type == "desktop" ]]; then
    touch $file   
    echo "\$type=desktop" > $file

elif [[ $type == "laptop" ]]; then
    touch $file   
    echo "\$type=laptop" > $file

else
    echo "Send notification error in dunst."
fi


case $(lspci | awk -F ':' '/VGA/ || /3D/ || /Display/ {split($3, subfield, " "); print subfield[1]}') in
    Advanced)
      echo "\$gpu=amd" >> $file
      ;;
    Intel)
      echo "\$gpu=intel" >> $file
      ;;
    NVIDIA)
      echo "\$gpu=nvidia" >> $file
      ;;
     *)
      echo "\$gpu=other" >> $file
      ;;
esac
