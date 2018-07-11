# site.mk for Freifunk Duesseldorf-Flingern

# for feature packs see https://github.com/freifunk-gluon/gluon/blob/v2018.1.x/package/features
GLUON_FEATURES := \
	web-wizard \
	web-advanced \
	mesh-batman-adv-15 \
	respondd \
	autoupdater \
	ebtables \
	ebtables-limit-arp \
	radv-filterd \
	ebtables-filter-multicast \
	ebtables-filter-ra-dhcp \
	mesh-vpn-fastd \
	radvd \
	status-page

# eulenfunk:
GLUON_SITE_PACKAGES := \
	gluon-weeklyreboot \
	gluon-hotfix \
	gluon-quickfix \
	gluon-txpowerfix \
	gluon-banner \
	gluon-linkcheck \
	gluon-ssid-changer 
# ffho not working, see https://github.com/FreifunkHochstift/ffho-packages/pull/8
#GLUON_SITE_PACKAGES += \
#	ffho-ath9k-blackout-workaround
# ffrl
GLUON_SITE_PACKAGES += \
	gluon-ebtables-filter-roguenets
# ffffm
GLUON_SITE_PACKAGES += \
	ffffm-keep-radio-channel \
	ffffm-additional-wifi-json-info
# ffki:
GLUON_SITE_PACKAGES += \
	gluon-config-mode-ppa
# openwrt:
GLUON_SITE_PACKAGES += \
	haveged \
	iptables \
	iwinfo \
	socat

DEFAULT_GLUON_RELEASE := SBRANCH

# Allow overriding the release number from the command line
GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)

GLUON_PRIORITY ?= 0
GLUON_LANGS ?= de en 
GLUON_REGION ?= eu
GLUON_ATH10K_MESH ?= 11s
