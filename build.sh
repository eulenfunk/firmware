rm -rf ../images/*

for f in bcd bgl kut lln ode ovr rrh
do
	rm site.conf
	rm -rf i18n
	cp site.conf.$f site.conf
	cp i18n.$f i18n
	cd ..
	make clean GLUON_TARGET=ar71xx-generic
	make -j20 GLUON_BRANCH=stable GLUON_TARGET=ar71xx-generic
	make manifest GLUON_BRANCH=stable GLUON_TARGET=ar71xx-generic
	contrib/sign.sh secret.key images/sysupgrade/stable.manifest
	mkdir -p images/$f/stable
	mv images/factory images/$f/stable/
	mv images/sysupgrade images/$f/stable/
	cd site
done
