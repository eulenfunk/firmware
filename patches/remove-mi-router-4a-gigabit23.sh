#!/bin/bash
echo $PWD 

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