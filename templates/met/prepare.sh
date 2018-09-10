#!/bin/bash
# git apply $(dirname $0)/keepradiochannel.diff
# echo "CONFIG_PATA_ATIIXP=y" >> openwrt/target/linux/x86/generic/config-default
 
cp ../patches/sysupgrade ./lede/package/base-files/files/sbin/sysupgrade
chmod +x ./lede/package/base-files/files/sbin/sysupgrade

