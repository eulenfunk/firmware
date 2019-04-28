# site.mk for Freifunk im Neanderland - gluon 2018.1.x

# for feature packs see https://github.com/freifunk-gluon/gluon/blob/v2018.2.x/package/features
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
	ebtables-source-filter \
	mesh-vpn-fastd \
	radvd \
	status-page\

# eulenfunk:
GLUON_SITE_PACKAGES := \
	gluon-weeklyreboot \
	gluon-hotfix \
	gluon-quickfix \
	gluon-txpowerfix \
	gluon-banner \
	gluon-linkcheck \
	gluon-authorized-keys \
    gluon-config-mode-autoupdater \
    gluon-config-mode-contact-info \
    gluon-config-mode-core \
    gluon-config-mode-hostname \
    gluon-config-mode-mesh-vpn \
    gluon-next-node \
    gluon-luci-admin \
    gluon-luci-autoupdater \
    gluon-luci-portconfig \
    gluon-luci-wifi-config \
    gluon-ebtables-filter-roguenets \
    eulenfunk-dns-cache \
	

# PROBLEM:
# ev. macht dieses paket:
# - ffho-ath9k-blackout-workaround
# das selbe wie diese beiden zusammen:
# - gluon-hotfix 
# - gluon-quickfix
# ffho not working, see https://github.com/FreifunkHochstift/ffho-packages/pull/8
#GLUON_SITE_PACKAGES += \
#	ffho-ath9k-blackout-workaround

# ffffm 
# ev. kann man ffffm-additional-wifi-json-info teilweise durch standard gluon respondd-module-airtime ersetzen
GLUON_SITE_PACKAGES += \
	ffffm-additional-wifi-json-info \
	ffffm-keep-radio-channel \
	ffffm-button-bind 

# ffki:
GLUON_SITE_PACKAGES += \
	gluon-config-mode-ppa \
	gluon-config-mode-geo-location-osm \


# ffnord:
GLUON_SITE_PACKAGES += \
	gluon-ssid-changer 

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
