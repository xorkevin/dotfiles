sinkh=$(pactl list short sinks | cut -f2 | grep 'FiiO')
sinks=$(pactl list short sinks | cut -f2 | grep 'hdmi')
pactl set-sink-mute $sinkh false
pactl set-sink-mute $sinks true
