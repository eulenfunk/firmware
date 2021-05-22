#!/bin/bash
echo $PWD 

addfile="../patches/add-NanoPi-R2S.target"
destfile="targets/rockchip-armv8"
cp $addfile $destfile

patchfile="../patches/add-NanoPi-R2S.patch"
if ! patch -R -p1 -s -f --ignore-whitespace --dry-run <$patchfile; then
  patch -p1 --ignore-whitespace <$patchfile
fi
grep 'rockchip,armv8'  targets/targets.mk
