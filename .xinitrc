#!/bin/sh

xrdb -merge "${HOME}/.Xresources"
urxvtd -q -o -f
exec awesome
