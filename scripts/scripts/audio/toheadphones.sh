#!/bin/sh

sinkh=$(pactl list short sinks | cut -f2 | grep 'FiiO')
sinks=$(pactl list short sinks | cut -f2 | grep 'Vanatoo')
if [ ! -z "$sinkh" ]; then
  pactl set-sink-mute "$sinkh" false
fi
if [ ! -z "$sinks" ]; then
  pactl set-sink-mute "$sinks" true
fi
