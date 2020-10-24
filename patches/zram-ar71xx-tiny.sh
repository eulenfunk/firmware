#!/bin/bash
echo $PWD 
patchfile="../patches/zram-ar71xx-tiny.patch"
if ! patch -R -p1 -s -f --ignore-whitespace --dry-run <$patchfile; then
  patch -p1 --ignore-whitespace <$patchfile
fi
grep 'zram-swap'  targets/ar71xx-tiny b/targets/ar71xx-tiny

