rm -rf ../images/*

for f in bcd bgl kut lln ode ovr rrh
do
	cd ..
	make clean GLUON_TARGET=ar71xx-generic GLUON_SITEDIR=site/$f GLUON_IMAGEDIR=images/$f
	make -j20 GLUON_BRANCH=stable GLUON_TARGET=ar71xx-generic GLUON_SITEDIR=site/$f GLUON_IMAGEDIR=images/$f
	make manifest GLUON_BRANCH=stable GLUON_TARGET=ar71xx-generic GLUON_SITEDIR=site/$f GLUON_IMAGEDIR=images/$f
	#contrib/sign.sh secret.key images/sysupgrade/stable.manifest
	cd site
done
