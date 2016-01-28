#!/bin/bash
#replace $2 with $3 in directory $1 recursively
function replace {
	find $1 -type f -print0 | xargs -0 sed -i "s;$2;$3;g"
}

#copy template $3 to sitecode $4 and replace SITECODE with $4, NAME with $5, and WEBSITE with $6
function makesite {
	DIR=assembled/$3/$4
	rm -rf $DIR
	mkdir -p assembled/$3
	cp -r templates/$3 $DIR
	replace $DIR SITECODE "$4"
	replace $DIR NAME "$5"
	replace $DIR WEBSITE "$6"
	replace $DIR RELBRANCH "$1"
}

function sites {
	rm -rf assembled
	while read L
	do
		makesite $L
	done < sites
	echo --- sites assembled ---
}

#build image for autoupdater branch $2, gluon branch $3, target $1, template $4, site $5
function image {
	cd $GLUON_DIR
	git fetch
	git stash
	git checkout $3 -f
	ARGS="GLUON_SITEDIR=$HOME_DIR/assembled/$4/$5 GLUON_IMAGEDIR=$HOME_DIR/images/$4/$5 GLUON_MODULEDIR=$HOME_DIR/modules GLUON_TARGET=$1 GLUON_BRANCH=$2"
	make update $ARGS
	make clean -j10 $ARGS
	$HOME_DIR/assembled/$4/$5/prepare.sh
	make -j10 $ARGS
	make manifest $ARGS
	cd $HOME_DIR
}

function images {
	if [ -z "$1" ]; then TARGET=ar71xx-generic; else TARGET="$1"; fi
	while read L
	do
		image $TARGET $L
	done < sites
	mv images{,-$(date +%s)}
	mv modules{,-$(date +%s)}
}

function all {
	sites
	images
}

function init {
	rm -rf gluon.bak
	mv gluon{.bak} 2>/dev/null
	git clone https://github.com/freifunk-gluon/gluon
}

HOME_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
GLUON_DIR="$HOME_DIR/gluon"
$@
