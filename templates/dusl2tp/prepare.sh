#!/bin/bash
# git apply $(dirname $0)/keepradiochannel.diff
# echo "CONFIG_PATA_ATIIXP=y" >> openwrt/target/linux/x86/generic/config-default
 
curl https://gist.githubusercontent.com/Adorfer/3c60347cf8599beed6c0f2d2124e95f5/raw/df1762934f99397b386af633636af37507e32982/sysupgrade  > ./lede/package/base-files/files/sbin/sysupgrade
chmod +x ./lede/package/base-files/files/sbin/sysupgrade


