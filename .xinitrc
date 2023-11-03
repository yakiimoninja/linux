#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Keyboard Layout
setxkbmap en &

# Display Resolution
xrandr --mode 1920x1080 &

# Compositor
# picom -f &

# Wallpaper
nitrogen --restore

# Night Light
redshift -O 3750 &

# Starting Thunar Authenticator
# dbus-launch &
# /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
# /usr/lib/polkit-1/polkitd

# Starting Dwm and Slstatus
slstatus &
#exec dwm

while :; do
	exec dwm
done
