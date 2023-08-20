#!/bin/sh

xrdb -merge "${HOME}/.Xresources"
xbindkeys
xset -dpms
xset s off
feh --bg-fill "${HOME}/Pictures/bg"
exec i3
