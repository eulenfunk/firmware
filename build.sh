cd ..
rm -rf images

make clean GLUON_TARGET=ar71xx-generic GLUON_SITEDIR=$PWD/site/bcd GLUON_IMAGEDIR=$PWD/images/$f/stable

for f in bcd bgl kut lln ode ovr rrh
do
	make -j20 GLUON_BRANCH=stable GLUON_TARGET=ar71xx-generic GLUON_SITEDIR=$PWD/site/$f GLUON_IMAGEDIR=$PWD/images/$f/stable
	make manifest GLUON_BRANCH=stable GLUON_TARGET=ar71xx-generic GLUON_SITEDIR=$PWD/site/$f GLUON_IMAGEDIR=$PWD/images/$f/stable
	#contrib/sign.sh secret.key $PWD/images/sysupgrade/stable.manifest
done
