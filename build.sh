#!/bin/bash

SCRIPTHOME=$(pwd)

echo -generating sites-

function mksite {
	#site_code name homepage arch [SSID]
	cp -r $SCRIPTHOME/examplearch/examplesitecode $SCRIPTHOME/sites/$4/$1
	sed -e "s/examplesitecode/$1/g" -i $SCRIPTHOME/sites/$4/$1/site.conf
	sed -e "s/examplename/$2/g" -i $SCRIPTHOME/sites/$4/$1/site.conf
	sed -e "s/examplearch/$4/g" -i $SCRIPTHOME/sites/$4/$1/site.conf
	sed -e "s/examplehomepage/$3/g" -i $SCRIPTHOME/sites/$4/$1/i18n/en.po
	sed -e "s/examplehomepage/$3/g" -i $SCRIPTHOME/sites/$4/$1/i18n/de.po
	sed -e "s/examplename/$2/g" -i $SCRIPTHOME/sites/$4/$1/i18n/en.po
	sed -e "s/examplename/$2/g" -i $SCRIPTHOME/sites/$4/$1/i18n/de.po
	sed -e "s/examplessid/$5/g" -i $SCRIPTHOME/sites/$4/$1/site.conf
}

rm -rf $SCRIPTHOME/sites

for ARCH in ar71xx-generic x86-generic x86-kvm_guest
do
	mkdir -p $SCRIPTHOME/sites/$ARCH
	mksite bcd Burscheid freifunk-burscheid.de $ARCH Freifunk-Burscheid
	mksite bgl "Bergisch Gladbach" freifunk-bergisch-gladbach.de $ARCH Freifunk
	mksite kut Kürten freifunk-gl.de $ARCH Freifunk
	mksite lln Leichlingen leichlingen.freifunk.net $ARCH Freifunk
	mksite ode Odenthal "odenthal.de\/freifunk.html" $ARCH Freifunk
	mksite ovr Overath freifunk-gl.de $ARCH Freifunk
	mksite rrh Rösrath freifunk-gl.de $ARCH Freifunk
done

echo done.

cd $SCRIPTHOME/build
rm -rf $SCRIPTHOME/oldimages
mv $SCRIPTHOME/images $SCRIPTHOME/oldimages

for g in ar71xx-generic x86-kvm_guest x86-generic
do
	for f in bcd bgl kut lln ode ovr rrh
	do
		echo -building $f $g-
		
		ARGS="GLUON_TARGET=$g GLUON_SITEDIR=$SCRIPTHOME/sites/$g/$f GLUON_IMAGEDIR=$SCRIPTHOME/images/$g/$f/stable GLUON_BRANCH=stable"
#		make update $ARGS
#		make clean $ARGS
		make -j20 $ARGS
		make manifest $ARGS
		contrib/sign.sh secret.key $SCRIPTHOME/images/$g/$f/stable/sysupgrade/stable.manifest
	done
done
