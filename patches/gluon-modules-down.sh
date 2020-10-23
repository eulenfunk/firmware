#!/bin/bash
echo $PWD 
patchfile="../patches/gluon-modules-down.patch"
if ! patch -R -p1 -s -f --ignore-whitespace --dry-run <$patchfile; then
  patch -p1 --ignore-whitespace <$patchfile
fi
grep '5af8da37870dc05dbe2e57e04be714b80f4aa21d'  package/gluon-core/luasrc/lib/gluon/upgrade/200-wireless

