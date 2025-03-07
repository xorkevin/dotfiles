if [ -z "$DISPLAY" ] && [ ! -z "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  export LIBVA_DRIVER_NAME=radeonsi
  exec startx
fi
