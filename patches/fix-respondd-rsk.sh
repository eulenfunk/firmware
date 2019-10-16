#!/bin/bash
echo $PWD 
patchfile="../patches/fix-respondd-rsk.patch"
if ! patch -R -p1 -s -f --ignore-whitespace --dry-run <$patchfile; then
  patch -p1 --ignore-whitespace <$patchfile
fi
grep 'ff02:'  package/gluon-respondd/files/etc/init.d/gluon-respondd
