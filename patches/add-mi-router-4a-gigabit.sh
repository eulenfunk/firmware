#!/bin/bash
echo $PWD 

patchfile="../patches/add-mi-router-4a-gigabit-gluon.patch"
if ! patch -R -p1 -s -f --ignore-whitespace --dry-run <$patchfile &>/dev/null; then
  patch -p1 --ignore-whitespace <$patchfile
fi
grep 'mi-router-4a-gigabit' targets/ramips-mt7621

cd openwrt 
patchfile="../../patches/add-mi-router-4a-gigabit-openwrt.patch"
if ! patch -R -p1 -s -f --ignore-whitespace --dry-run <$patchfile &>/dev/null; then
  patch -p1 --ignore-whitespace <$patchfile
fi
grep  'mi-router-4a-gigabit' target/linux/ramips/image/mt7621.mk

