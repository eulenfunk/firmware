#!/bin/bash
echo $PWD 

if [ "$1" == "ramips-mt7621" ] && [ "$2" == "mi-router-4a-gigabit" ]
 then

  patchfile="../patches/add-mi-router-4a-gigabit-gluon.patch"
  if ! patch -R -p1 -s -f --ignore-whitespace --dry-run <$patchfile &>/dev/null; then
    patch -p1 --ignore-whitespace <$patchfile
   fi
  grep 'mi-router-4a-gigabit' targets/ramips-mt7621

  cd openwrt 
  patchfile="../../patches/add-mi-router-4a-gigabit-openwrt23.patch"
  if ! patch -R -p1 -s -f --ignore-whitespace --dry-run <$patchfile &>/dev/null; then
    patch -p1 --ignore-whitespace <$patchfile
   fi
  grep  'mi-router-4a-gigabit' target/linux/ramips/image/mt7621.mk

  #[ -f target/linux/ramips/dts/XIAOMI-MIR4A-GIGABIT.dts ] && echo "target/linux/ramips/dts/XIAOMI-MIR4A-GIGABIT.dts exists, skipping copy." || cp ../../patches/XIAOMI-MIR4A-GIGABIT.dts target/linux/ramips/dts/XIAOMI-MIR4A-GIGABIT.dts
  #[ -f target/linux/ramips/base-files/sbin/u-boot-upgrade ] && echo "target/linux/ramips/base-files/sbin/u-boot-upgrade exists, skipping copy." || cp ../../patches/u-boot-upgrade target/linux/ramips/base-files/sbin/u-boot-upgrade
  #[ -f target/linux/generic/pending-4.14/690-net-add-support-for-threaded-NAPI-polling.patch ] && echo "target/linux/generic/pending-4.14/690-net-add-support-for-threaded-NAPI-polling.patch exists, skipping copy." || cp ../../patches/690-net-add-support-for-threaded-NAPI-polling.patch target/linux/generic/pending-4.14/690-net-add-support-for-threaded-NAPI-polling.patch
 else
  grep 'mi-router-4a-gigabit' targets/ramips-mt7621
  if grep -q 'mi-router-4a-gigabit' "targets/ramips-mt7621"; then
    echo unpatching ramips-mt7621-target from gluon
    rm -rf .git/rebase-apply
    git reset --hard
    fi

  cd openwrt
  grep  'mi-router-4a-gigabit' target/linux/ramips/image/mt7621.mk
  if grep -q 'mi-router-4a-gigabit' "target/linux/ramips/image/mt7621.mk"; then
    echo unpatching ramips-mt7621 from openwrt
    rm -rf .git/rebase-apply
    git reset --hard
    [ -f target/linux/ramips/dts/XIAOMI-MIR4A-GIGABIT.dts ] && rm target/linux/ramips/dts/XIAOMI-MIR4A-GIGABIT.dts
    [ -f target/linux/ramips/base-files/sbin/u-boot-upgrade ] && rm target/linux/ramips/base-files/sbin/u-boot-upgrade
    [ -f target/linux/generic/pending-4.14/690-net-add-support-for-threaded-NAPI-polling.patch ] && rm target/linux/generic/pending-4.14/690-net-add-support-for-threaded-NAPI-polling.patch
   fi
 fi