#!/bin/sh

TMPDIR=/tmp/i3
TMPFILE=$TMPDIR/screen_locked.png
rm -f $TMPFILE \
  && mkdir -p $TMPDIR \
  && maim -u $TMPFILE \
  && convert $TMPFILE -sample 12.5% -scale 12.5% -scale 6400% $TMPFILE \
  && i3lock -i $TMPFILE
