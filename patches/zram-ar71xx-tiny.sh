#!/bin/bash
echo $PWD 
patchfile="../patches/zram-ar71xx-tiny.patch"
if ! patch -R -p1 -s -f --ignore-whitespace --dry-run <$patchfile &>/dev/null; then
  patch -p1 --ignore-whitespace <$patchfile
fi
grep 'zram-swap'  targets/ar71xx-tiny 

cd openwrt 
patchfile="../../patches/zram-ar71xx-tiny-kernel.patch"
if ! patch -R -p1 -s -f --ignore-whitespace --dry-run <$patchfile &>/dev/null; then
  patch -p1 --ignore-whitespace <$patchfile
fi
grep 'CONFIG_SWAP'  target/linux/ar71xx/tiny/config-default

