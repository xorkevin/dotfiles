#!/usr/bin/env bash

out=gpgkeys
fileout=$out.tar.gz
tmpdir=/tmp/gpgbackup
tmppath=$tmpdir/$out

rm -r $tmpdir
mkdir -p $tmppath

gpg --armor --export > $tmppath/public.asc \
  && gpg --armor --export-secret-keys > $tmppath/private.asc \
  && gpg --armor --export-ownertrust > $tmppath/trust.asc \
  && tar czvf $fileout -C $tmpdir $out \
  && gpg -c $fileout

rm -r $tmpdir
rm $fileout
