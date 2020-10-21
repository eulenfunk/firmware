#!/bin/bash
echo $PWD 

patchfile="../patches/backport-gluon2020-02.patch"
if ! patch -R -p1 -s -f --ignore-whitespace --dry-run <$patchfile; then
  patch -p1 --ignore-whitespace <$patchfile
fi
grep 'archer-c6-v2'  targets/ath79-generic
