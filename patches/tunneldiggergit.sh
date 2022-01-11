#!/bin/bash
echo $PWD 
patchfile="../../../patches/tunneldiggergit.sh.patch"
#/gluon/packages/gluon/
if ! patch -R -p1 -s -f --ignore-whitespace --dry-run <$patchfile &>/dev/null; then
  patch -p1 --ignore-whitespace <$patchfile
fi
grep 'https://github.com/wlanslovenija/tunneldigger' net/tunneldigger/Makefile b/net/tunneldigger/Makefile