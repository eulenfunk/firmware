#!/bin/bash
echo $PWD 
patchfile="../patches/fix-DIR615c1-imagetoobig.patch"
if ! patch -R -p1 -s -f --ignore-whitespace --dry-run <$patchfile &>/dev/null; then
  patch -p1 --ignore-whitespace <$patchfile
fi
grep 'DIR615C1'  targets/ar71xx-tiny

