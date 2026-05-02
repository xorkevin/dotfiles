#!/bin/sh

xrdb -merge "${HOME}/.Xresources"
xbindkeys
xset -dpms
xset s off
feh --bg-fill "${HOME}/Pictures/bg"

xinitdir="/etc/X11/xinit"

if [ -d "$xinitdir"/xinitrc.d ] ; then
        for f in "$xinitdir/xinitrc.d"/?*.sh ; do
                [ -x "$f" ] && . "$f"
        done
        unset f
fi

exec i3
