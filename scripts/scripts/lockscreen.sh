#!/bin/sh

screendim="3840x2160"

if command -v convert > /dev/null && [ -e "$HOME/Pictures/lock" ]; then
  convert "$HOME/Pictures/lock" -resize "${screendim}^" \
    -gravity Center -extent "$screendim" RGB:- \
    | i3lock --raw "${screendim}:rgb" --image /dev/stdin
else
  i3lock --color 000000
fi
