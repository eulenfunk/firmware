#!/bin/bash
echo $PWD 
patchfile="../patches/gluon-modules-down.patch"
if ! patch -R -p1 -s -f --ignore-whitespace --dry-run <$patchfile &>/dev/null; then
  patch -p1 --ignore-whitespace <$patchfile
fi
grep '5af8da37870dc05dbe2e57e04be714b80f4aa21d'  modules

## as of 2020-05 
#GLUON_FEEDS='packages routing gluon'
#
#OPENWRT_REPO=https://git.openwrt.org/openwrt/openwrt.git
#OPENWRT_BRANCH=openwrt-19.07
#OPENWRT_COMMIT=9cafcbe0bdd601d07ed55bee0136f5d8393c37a8
#
#PACKAGES_PACKAGES_REPO=https://github.com/openwrt/packages.git
#PACKAGES_PACKAGES_BRANCH=openwrt-19.07
#PACKAGES_PACKAGES_COMMIT=af5ada4574121bfb2f84f9e1d8edc29ebc3965a7
#
#PACKAGES_ROUTING_REPO=https://github.com/openwrt-routing/packages.git
#PACKAGES_ROUTING_BRANCH=openwrt-19.07
#PACKAGES_ROUTING_COMMIT=9b42e24a54f03ebb6f58224b49036e8f739b175f
#
#PACKAGES_GLUON_REPO=https://github.com/freifunk-gluon/packages.git
#PACKAGES_GLUON_COMMIT=12e41d0ff07ec54bbd67a31ab50d12ca04f2238c

## as of 2020-10-23
#diff --git a/modules b/modules
#index 0b535a55..47be9ce7 100644
#--- a/modules
#+++ b/modules
#@@ -2,11 +2,11 @@ GLUON_FEEDS='packages routing gluon'
#
# OPENWRT_REPO=https://github.com/openwrt/openwrt.git
# OPENWRT_BRANCH=openwrt-19.07
#-OPENWRT_COMMIT=29b4104d69bf91db17764dd885e9e111a373f08c
#+OPENWRT_COMMIT=5af8da37870dc05dbe2e57e04be714b80f4aa21d
#
# PACKAGES_PACKAGES_REPO=https://github.com/openwrt/packages.git
# PACKAGES_PACKAGES_BRANCH=openwrt-19.07
#-PACKAGES_PACKAGES_COMMIT=a2673dc53c4689798c1d70d7342cb3efadb0af74
#+PACKAGES_PACKAGES_COMMIT=59d39c09d84fb08675cc58d4ec32837e9163b017
#
# PACKAGES_ROUTING_REPO=https://github.com/openwrt-routing/packages.git
# PACKAGES_ROUTING_BRANCH=openwrt-19.07

