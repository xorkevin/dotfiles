#!/bin/sh

sinkh=$(pactl list short sinks | cut -f2 | grep 'FiiO')
sinks=$(pactl list short sinks | cut -f2 | grep 'Vanatoo')
if [ ( ! -z "$sinkh" ) -a ( ! -z "$sinks" ) ]; then
  pactl set-sink-mute "$sinkh" true
  pactl set-sink-mute "$sinks" false
fi
