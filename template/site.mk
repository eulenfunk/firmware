GLUON_FEATURES := \
	autoupdater \
	ebtables-filter-multicast \
	ebtables-filter-ra-dhcp \
	mesh-batman-adv-15 \
	mesh-vpn-fastd \
	radvd \
	respondd \
	status-page \
	web-advanced \
	web-wizard

GLUON_SITE_PACKAGES := haveged iwinfo

DEFAULT_GLUON_RELEASE := $(shell date '+%Y%m%d')
GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)
GLUON_PRIORITY ?= 0
GLUON_REGION ?= eu
GLUON_LANGS ?= en de fr
GLUON_ATH10K_MESH := 11s
GLUON_IMAGEDIR := $(GLUON_OUTPUTDIR)/{{ site_code }}/$(GLUON_BRANCH)
