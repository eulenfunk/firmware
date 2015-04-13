rm -rf ../images/*

for f in bcd lln bgl ode
do
	rm site.conf
	cp site.conf.$f site.conf
	cd ..
	make clean
	make -j20 GLUON_BRANCH=stable
	make manifest GLUON_BRANCH=stable
	contrib/sign.sh secret.key images/sysupgrade/stable.manifest
	mkdir images/$f/stable
	mv images/factory images/$f/stable/
	mv images/sysupgrade images/$f/stable/
	cd site
done

ssh root@gl1.ffgl "rm -rf /srv/http/firmware/*"
scp -r images/* root@gl1.ffgl:/srv/http/firmware/
