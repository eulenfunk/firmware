#!/bin/bash
echo $PWD 
patchfile="../patches/ignore-preservechannels-for-outdoormode.patch"
if ! patch -R -p1 -s -f --ignore-whitespace --dry-run <$patchfile; then
  patch -p1 --ignore-whitespace <$patchfile
fi
