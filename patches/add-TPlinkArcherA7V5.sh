#!/bin/bash
echo $PWD 

patchfile="../patches/add-TPlinkArcherA7V5.patch"
if ! patch -R -p1 -s -f --ignore-whitespace --dry-run <$patchfile &>/dev/null; then
  patch -p1 --ignore-whitespace <$patchfile
fi
grep 'archer-a7-v5'  targets/ath79-generic
