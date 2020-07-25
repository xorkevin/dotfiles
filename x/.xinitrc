#!/bin/sh

xrdb -merge "${HOME}/.Xresources"
#xrandr --output DisplayPort-2 --auto --primary --pos 1920x0 --output HDMI-0 --auto --pos 0x360
xbindkeys
xset m 1 0
xset s 3600 3600
xset dpms 3600 3600 3600
feh --bg-fill "${HOME}/Pictures/bg"
exec i3
