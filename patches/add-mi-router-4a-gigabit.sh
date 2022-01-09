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

cp ../../patches/XIAOMI-MIR4A-GIGABIT.dts target/linux/ramips/dts/XIAOMI-MIR4A-GIGABIT.dts
cp ../../patches/u-boot-upgrade target/linux/ramips/base-files/sbin/u-boot-upgrade
cp ../../patches/690-net-add-support-for-threaded-NAPI-polling.patch target/linux/generic/pending-4.14/690-net-add-support-for-threaded-NAPI-polling.patch
