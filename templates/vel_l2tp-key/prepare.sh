#!/bin/bash
# git apply $(dirname $0)/keepradiochannel.diff
# echo "CONFIG_PATA_ATIIXP=y" >> openwrt/target/linux/x86/generic/config-default
 
#cp ../patches/sysupgrade ./openwrt/package/base-files/files/sbin/sysupgrade
#chmod +x ./openwrt/package/base-files/files/sbin/sysupgrade

cd ../gluon ; ../patches/fix-respondd-rsk.sh  # change respondd listener address to gluon 2016.x value

