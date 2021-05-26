#!/bin/bash
echo $PWD 
patchfile="../patches/kernelswapon.patch"
if ! patch -R -p1 -s -f --ignore-whitespace --dry-run <$patchfile &>/dev/null; then
  patch -p1 --ignore-whitespace <$patchfile
fi
grep 'KERNEL_SWAP'  scripts/target_config_lib.lua 

cd openwrt 
patchfile="../../patches/kernelswapon-openwrt.patch"
if ! patch -R -p1 -s -f --ignore-whitespace --dry-run <$patchfile &>/dev/null; then
  patch -p1 --ignore-whitespace <$patchfile
fi

