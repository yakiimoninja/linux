#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Rust enviroment entry
. "$HOME/.cargo/env"

if [ -d "$HOME/Downloads/platform-tools" ] ; then
 export PATH="$HOME/Downloads/platform-tools:$PATH"
fi

# Starting window manager
Hyprland
