#!/bin/bash

SCRIPTHOME=$(pwd)

echo -generating sites-

ARCHS="ar71xx-generic ar71xx-nand mpc85xx-generic ramips-rt305x x86-kvm_guest x86-generic"

function mksite {
	#site_code name homepage SSID
	cp -r $SCRIPTHOME/examplesitecode $SCRIPTHOME/sites/$1
	sed -e "s/examplesitecode/$1/g" -i $SCRIPTHOME/sites/$1/site.conf
	sed -e "s/examplename/$2/g" -i $SCRIPTHOME/sites/$1/site.conf
	sed -e "s/examplehomepage/$3/g" -i $SCRIPTHOME/sites/$1/i18n/en.po
	sed -e "s/examplehomepage/$3/g" -i $SCRIPTHOME/sites/$1/i18n/de.po
	sed -e "s/examplename/$2/g" -i $SCRIPTHOME/sites/$1/i18n/en.po
	sed -e "s/examplename/$2/g" -i $SCRIPTHOME/sites/$1/i18n/de.po
	sed -e "s/examplessid/$4/g" -i $SCRIPTHOME/sites/$1/site.conf
}

rm -rf $SCRIPTHOME/sites
mkdir -p $SCRIPTHOME/sites
mksite bcd Burscheid freifunk-burscheid.de Freifunk-Burscheid
mksite bgl "Bergisch Gladbach" freifunk-bergisch-gladbach.de Freifunk
mksite kut Kürten freifunk-gl.de Freifunk
mksite lln Leichlingen leichlingen.freifunk.net Freifunk
mksite ode Odenthal "odenthal.de\/freifunk.html" Freifunk
mksite ovr Overath freifunk-gl.de Freifunk
mksite rrh Rösrath freifunk-gl.de Freifunk

echo done.

cd $SCRIPTHOME/build
rm -rf $SCRIPTHOME/oldimages
mv $SCRIPTHOME/images $SCRIPTHOME/oldimages

for f in bcd bgl kut lln ode ovr rrh
do
	for g in ar71xx-generic ar71xx-nand mpc85xx-generic ramips-rt305x x86-kvm_guest x86-generic
	do
		echo -building $f $g-
		ARGS="GLUON_TARGET=$g GLUON_SITEDIR=$SCRIPTHOME/sites/$f GLUON_IMAGEDIR=$SCRIPTHOME/images/$f/stable GLUON_BRANCH=stable"
#		make update $ARGS
#		make clean $ARGS
		make -j20 $ARGS
	done
	make manifest $ARGS
	contrib/sign.sh secret.key $SCRIPTHOME/images/$f/stable/sysupgrade/stable.manifest
done
