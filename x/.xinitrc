#!/bin/sh

xrdb -merge "${HOME}/.Xresources"
#xrandr --output DisplayPort-2 --auto --primary --pos 1920x0 --output HDMI-0 --auto --pos 0x360
xbindkeys
xset m 0 0
mousedevice=$(xinput --list --name-only | grep 'Naos' | grep -v 'Keyboard')
if [ ! -z $mousedevice ]; then
  mousedeviceid=$(xinput --list --id-only "$mousedevice")
  xinput --set-prop "$mousedeviceid" 'libinput Accel Profile Enabled' 0, 1
fi
xset s 3600 3600
xset dpms 3600 3600 3600
feh --bg-fill "${HOME}/Pictures/bg"
exec i3
