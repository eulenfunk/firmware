#!/bin/bash
#replace $2 with $3 in directory $1 recursively
function replace {
	find $1 -type f -print0 | xargs -0 sed -i "s;$2;$3;g"
}

#copy template $3 to sitecode $4 and replace SITECODE with $4, NAME with $5, and WEBSITE with $6
function makesite {
	RELBRANCH=$1
	DIR=assembled/$3/$4
	rm -rf $DIR
	mkdir -p assembled/$3
	cp -r templates/$3 $DIR
	replace $DIR SITECODE "$4"
	NAME=$(echo $5 | sed 's/:/ /g')
	replace $DIR NAME "$NAME"
	replace $DIR WEBSITE "$6"
	replace $DIR RELBRANCH "$1"
	replace $DIR STARTDATE "$STARTDATE"
##ffdus
	SBRANCH="$(date +%Y%m%d%H)-$(echo $RELBRANCH| cut -c1-3|tr '[:upper:]' '[:lower:]')"
##neander
#	SBRANCH="$(date +%Y%m%d%H%M)"

	echo sbranch $SBRANCH
	replace $DIR SBRANCH "$SBRANCH"
}

function sites {
	rm -rf assembled
	while read L
	do
	 	if [[ ! -z "${L// }" ]]
	 	then
 			makesite $L
 		fi
	done < $1
	echo --- sites assembled ---
}

#build image for autoupdater branch $2, gluon branch $3, target $1, template $4, site $5, broken $6
function image {
		PREP=$(cat $HOME_DIR/.prepared)
		rm $HOME_DIR/.prepared
		ARGS="GLUON_SITEDIR=$HOME_DIR/assembled/$3/$4 GLUON_IMAGEDIR=$HOME_DIR/images/$3/$4 GLUON_MODULEDIR=$HOME_DIR/modules GLUON_BRANCH=$1 BROKEN=$6"
		if [ "$PREP" != "$3" ]
		then
			git fetch --all >> $HOME_DIR/assembled/$3/$4/build.log
#			git reset --hard $2
			make update $ARGS >> $HOME_DIR/assembled/$3/$4/build.log || exit 1
			for TARGET in $TARGETS
			do
			echo 	make clean $ARGS GLUON_TARGET=$TARGET 
			make clean $ARGS GLUON_TARGET=$TARGET >> $HOME_DIR/assembled/$3/$4/build.log
			done
			$HOME_DIR/assembled/$3/$4/prepare.sh
		fi
		for TARGET in $TARGETS
		do
			if make -j16 $ARGS GLUON_TARGET=$TARGET BROKEN=1 V=s >> $HOME_DIR/assembled/$3/$4/build.log 
			then
				echo build successful
			else
				make V=s -j1 $ARGS GLUON_TARGET=$TARGET BROKEN=1
				exit 1
			fi
		done
		echo $3 > $HOME_DIR/.prepared
		make manifest $ARGS >> $HOME_DIR/assembled/$3/$4/build.log 
		gzip $HOME_DIR/assembled/$3/$4/build.log
		mkdir $HOME_DIR/images/$3/$4/site
		rsync -a $HOME_DIR/assembled/$3/$4/ --exclude '*.old' --exclude '*.backup'  --exclude '*~'  --exclude '*.nonworking'   $HOME_DIR/images/$3/$4/site
		rsync -a $HOME_DIR/build.sh --exclude '*.old' --exclude '*.backup'  --exclude '*~'  --exclude '*.nonworking'   $HOME_DIR/images/$3/$4/site
		rsync -a $HOME_DIR/$1 --exclude '*.old' --exclude '*.backup'  --exclude '*~'  --exclude '*.nonworking'   $HOME_DIR/images/$3/$4/site
}

function images {
## choices:
# * ar71xx-generic
# * ar71xx-tiny
# * ar71xx-nand
# * brcm2708-bcm2708
# * brcm2708-bcm2709
# * mpc85xx-generic
# * ramips-mt7621
# * sunxi
# * x86-generic
# * x86-geode
# * x86-64
# * ipq806x
# * ramips-mt7620
# * ramips-mt7628
# * ramips-rt305x
# * ar71xx-mikrotik
# * brcm2708-bcm2710
# * mvebu

	if [ -z "$2" ]; then TARGETS="ar71xx-generic ar71xx-tiny ar71xx-nand brcm2708-bcm2708 brcm2708-bcm2709 mpc85xx-generic ramips-mt7621 sunxi x86-generic x86-geode x86-64 ipq806x ramips-mt7620 ramips-mt7628 ramips-rt305x ar71xx-mikrotik brcm2708-bcm2710 mvebu"; else TARGETS=$(echo $@ | cut -d' ' -f2-); fi
#	# if [ -z "$2" ]; then TARGETS="ar71xx-generic ar71xx-nand mpc85xx-generic x86-generic x86-kvm_guest x86-xen_domu x86-64"; else TARGETS=$(echo $@ | cut -d' ' -f2-); fi
#	if [ -z "$2" ]; then TARGETS="ar71xx-generic ar71xx-nand mpc85xx-generic x86-generic x86-kvm_guest x86-64 brcm2708-bcm2708 brcm2708-bcm2709"; else TARGETS=$(echo $@ | cut -d' ' -f2-); fi
#	if [ -z "$2" ]; then TARGETS="ar71xx-generic ar71xx-nand mpc85xx-generic x86-generic x86-kvm_guest x86-64"; else TARGETS=$(echo $@ | cut -d' ' -f2-); fi
#	if [ -z "$2" ]; then TARGETS="ar71xx-generic"; else TARGETS=$(echo $@ | cut -d' ' -f2-); fi
	cd $GLUON_DIR
	while read L
	do
		image $L
	done < $HOME_DIR/$1
	cd $HOME_DIR
	mv images{,-$(date +%s)}
	mv modules{,-$(date +%s)}
}

function init {
	rm -rf gluon.bak
	mv gluon{.bak} 2>/dev/null
	git clone https://github.com/freifunk-gluon/gluon $GLUON_DIR
}

function ci {
	if [ ! -d "GLUON_DIR" ]; then
		init
	fi
	all
}

function help {
	echo 'Usage: build.sh <sites file> [target1] [target2] [...]'
}

HOME_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
GLUON_DIR="$HOME_DIR/gluon"
STARTDATE="$(date +%Y%m%d)"
if [ $(pgrep $(basename $1) | wc -l) -gt 2 ]
then
        echo already running, exiting.
        exit
fi

if [ -f "$1" ]
then
	sites $1
	images $@
elif [ -z "$1" ]
then
	help
else
	$@
fi
