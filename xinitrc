#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/init/.Xresources
sysmodmap=/etc/X11/init/.Xmodmap

if [ -f $sysresources ]; then
    xrdb -merge "$sysresources"
fi

if [ -f $sysmodmap ]; then
    xmodmap "$sysmodmap"
fi

if [ -f $userresources ]; then
    xrdb -merge $"userresources"
fi

if [ -f $usermodmap ]; then
    xmodmap "$usermodmap"
fi

# Start programs in /etc/X11/xinit/xinitrc.d
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# Preferences
xset r rate 160 40
xrdb -I$HOME ~/.Xresources

# Start window manager
exec i3
