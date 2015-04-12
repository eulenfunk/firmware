rm -rf ../images/*

for f in site.conf.*
do
	rm site.conf
	cp $f site.conf
	cd ..
	make clean
	make -j20 GLUON_BRANCH=stable
	make manifest GLUON_BRANCH=stable
	contrib/sign.sh secret.key images/sysupgrade/stable.manifest
	rm -rf images/${f##*.}
	mkdir images/{f##*.}
	mv images/factory images/{f##*.}/
	mv images/sysupgrade images/{f##*.}/
	cd site
done

ssh root@gl1.ffgl "rm -rf /srv/http/firmware/*"
scp -r images/* root@gl1.ffgl:/srv/http/firmware/
