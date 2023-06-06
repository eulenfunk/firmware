#!/bin/bash
# git apply $(dirname $0)/keepradiochannel.diff
# echo "CONFIG_PATA_ATIIXP=y" >> openwrt/target/linux/x86/generic/config-default
 
#cp ../patches/sysupgrade ./openwrt/package/base-files/files/sbin/sysupgrade
#chmod +x ./openwrt/package/base-files/files/sbin/sysupgrade

pushd ../gluon ; git am ../patches/0001-*; popd ; # apply 0001-enumerated patches automaticylly
pushd ../gluon ; ../patches/fix-respondd-rsk.sh; popd  # change respondd listener address to gluon 2016.x value
pushd ../gluon/packages/gluon ; ../../../patches/respondd2021-1-1-6-radiooffcrash.sh; popd  # prevent crashes of respondd if radios installed but turned completly off.
pushd ../gluon ; ../patches/fix-DIR615c1-imagetoobig.sh; popd # remove DIR615C1 beeing too big
pushd ../gluon ; ../patches/add-TPlinkArcherA7V5.sh; popd # adding TP-Link Archer A7-V5
pushd ../gluon ; ../patches/kernelswapon.sh; popd # enable swap for all
pushd ../gluon ; ../patches/ignore-preservechannels-for-outdoormode.sh ; popd # correct handling of outdoor-devices (enable auto-channel)
pushd ../gluon ; ../patches/add-mi-router-4a-gigabit23.sh; popd # adding Xiaomi -mi-router-4a-gigabit edition

exit 0;

