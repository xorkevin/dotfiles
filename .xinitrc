#!/bin/sh

xrdb -merge "${HOME}/.Xresources"
urxvtd -q -o -f
xmodmap "${HOME}/.xmodmap"
mpd
exec i3
