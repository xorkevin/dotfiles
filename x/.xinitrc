#!/bin/sh

xrdb -merge "${HOME}/.Xresources"
xbindkeys
xset s 3600 3600
xset dpms 3600 3600 3600
feh --bg-fill "${HOME}/Pictures/bg"
exec i3
