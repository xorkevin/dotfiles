#!/bin/sh

xrdb -merge "${HOME}/.Xresources"
urxvtd -q -o -f
xmodmap "${HOME}/.xmodmap"
exec i3
