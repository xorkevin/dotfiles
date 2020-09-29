if [ -z "$DISPLAY" ] && [ ! -z "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx
fi
