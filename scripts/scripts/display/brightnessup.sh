#!/bin/sh

brightnessctl set +5%
killall -USR1 i3status
