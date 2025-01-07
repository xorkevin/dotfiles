#!/bin/sh

sinkh=$(pactl list short sinks | cut -f2 | grep 'bluez')
sinks=$(pactl list short sinks | cut -f2 | grep 'analog-stereo')
if [ ! -z "$sinkh" ]; then
  pactl set-sink-mute "$sinkh" true
fi
if [ ! -z "$sinks" ]; then
  pactl set-sink-mute "$sinks" false
fi
