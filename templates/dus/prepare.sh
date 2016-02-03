#!/bin/bash
git apply $(dirname $0)/keepradiochannel.diff
echo "CONFIG_PATA_ATIIXP=y" >> /home/build/firmware/gluon/openwrt/target/linux/x86/generic/config-default


