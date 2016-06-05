#!/bin/sh

xrdb -merge "${HOME}/.Xresources"
xrandr --output HDMI-0 --auto --left-of DisplayPort-2
urxvtd -q -o -f
xmodmap "${HOME}/.xmodmap"
mpd
exec i3
