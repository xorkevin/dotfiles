#!/bin/sh

brightnessctl set 1%-
killall -USR1 i3status
