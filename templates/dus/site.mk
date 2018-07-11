# site.mk for Freifunk Duesseldorf-Flingern

GLUON_FEATURES := \
	web-wizard
	web-advanced
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
	gluon-ebtables-limit-arp \
	gluon-weeklyreboot \
	gluon-hotfix \
	gluon-quickfix \
	gluon-txpowerfix \
	eulenfunk-dns-cache \
	gluon-banner \
	gluon-linkcheck
# ssid_changer (Freifunk Nord):
GLUON_SITE_PACKAGES += \
	gluon-ssid-changer 
# ffho:
GLUON_SITE_PACKAGES += \
	ffho-ath9k-blackout-workaround
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
