#!/bin/bash
echo $PWD 
patchfile="../../../patches/respondd2021-1-1-6-radiooffcrash.patch"
#/gluon/packages/gluon/
if ! patch -R -p1 -s -f --ignore-whitespace --dry-run <$patchfile &>/dev/null; then
  patch -p1 --ignore-whitespace <$patchfile
fi
grep 'off-channel' net/respondd-module-airtime/src/airtime.c