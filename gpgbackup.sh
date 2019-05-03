#!/usr/bin/env bash

out=gpgkeys
fileout=$out.tar.gz

mkdir -p $out

gpg --armor --export > $out/public.asc \
  && gpg --armor --export-secret-keys > $out/private.asc \
  && gpg --armor --export-ownertrust > $out/trust.asc \
  && tar czvf $fileout $out

gpg -c $fileout

rm -r $out
rm $fileout
