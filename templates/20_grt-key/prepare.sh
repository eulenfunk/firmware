#!/bin/bash
# git apply $(dirname $0)/keepradiochannel.diff
# echo "CONFIG_PATA_ATIIXP=y" >> openwrt/target/linux/x86/generic/config-default
 
#cp ../patches/sysupgrade ./openwrt/package/base-files/files/sbin/sysupgrade
#chmod +x ./openwrt/package/base-files/files/sbin/sysupgrade

cd ../gluon ; ../patches/fix-respondd-rsk.sh  # change respondd listener address to gluon 2016.x value
cd ../gluon ; ../patches/fix-DIR615c1-imagetoobig.sh # remove DIR615C1 beeing too big
cd ../gluon ; ../patches/add-TPlinkArcherA7V5.sh # adding TP-Link Archer A7-V5
#cd ../gluon ; ../patches/add-NanoPi-R2S.sh # adding  FriendlyARM NanoPi R2S
cd ../gluon ; ../patches/kernelswapon.sh # enable swap for all
cd ../gluon ; ../patches/ignore-preservechannels-for-outdoormode.sh # correct handling of outdoor-devices (enable auto-channel)
#cd ../gluon ; ../patches/gluon-modules-down.sh # downdate kernel/packages of gluon/openwrt (OOM-mitigation attempt von 4/32 ath9k)
exit 0;

