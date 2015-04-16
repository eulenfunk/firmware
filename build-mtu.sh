rm -rf ../images/*

for f in bcd lln bgl ode
do
	rm site.conf
	cp site.conf.$f.mtu site.conf
	cd ..
	make clean
	make -j6 GLUON_BRANCH=stable
	make manifest GLUON_BRANCH=stable
	contrib/sign.sh secret.key images/sysupgrade/stable.manifest
	mkdir -p images/mtu/$f/stable
	mv images/factory images/mtu/$f/stable/
	mv images/sysupgrade images/mtu/$f/stable/
	cd site
done

ssh root@gl1.ffgl "rm -rf /srv/http/firmware/*"
scp -r images/mtu/* root@gl1.ffgl:/srv/http/firmware/mtu/
