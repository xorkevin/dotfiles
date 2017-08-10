#!/bin/sh

xrdb -merge "${HOME}/.Xresources"
xrandr --output DisplayPort-2 --auto --primary --pos 1920x0 --output HDMI-0 --auto --pos 0x360
urxvtd -q -o -f
xmodmap "${HOME}/.xmodmap"
xbindkeys
feh --bg-fill "${HOME}/Pictures/bg"
exec i3

