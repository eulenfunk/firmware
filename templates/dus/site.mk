# site.mk for Freifunk Duesseldorf-Flingern

# standard gluon:
GLUON_SITE_PACKAGES := \
	gluon-mesh-batman-adv-15 \
	gluon-respondd \
	gluon-autoupdater \
	gluon-config-mode-autoupdater \
	gluon-config-mode-contact-info \
	gluon-config-mode-core \
	gluon-config-mode-geo-location \
	gluon-config-mode-hostname \
	gluon-config-mode-mesh-vpn \
	gluon-ebtables \
	gluon-ebtables-segment-mld \
	gluon-ebtables-filter-multicast \
	gluon-ebtables-filter-ra-dhcp
# eulenfunk:
GLUON_SITE_PACKAGES += \
	gluon-ebtables-limit-arp
# standard gluon:
GLUON_SITE_PACKAGES += \
	gluon-next-node \
	gluon-luci-admin \
	gluon-luci-autoupdater \
	gluon-luci-portconfig \
	gluon-luci-wifi-config \
	gluon-mesh-vpn-fastd \
	gluon-radvd \
	gluon-setup-mode \
	gluon-status-page
# eulenfunk:
GLUON_SITE_PACKAGES += \
	gluon-weeklyreboot \
	gluon-ssid-changer \
	gluon-hotfix \
	gluon-quickfix \
	gluon-txpowerfix
# ffho:
GLUON_SITE_PACKAGES += \
	ffho-ath9k-blackout-workaround
# openwrt:
GLUON_SITE_PACKAGES += \
	haveged \
	iptables \
	iwinfo
# ffrl_packages:
GLUON_SITE_PACKAGES += \
	gluon-ebtables-filter-roguenets \
	ffffm-keep-radio-channel \
	ffffm-additional-wifi-json-info
# eulenfunk:
GLUON_SITE_PACKAGES += \
	eulenfunk-dns-cache \
	gluon-banner \
	gluon-linkcheck
# ffki:
GLUON_SITE_PACKAGES += \
	gluon-config-mode-ppa
# openwrt:
GLUON_SITE_PACKAGES += \
	socat

DEFAULT_GLUON_RELEASE := SBRANCH

# Allow overriding the release number from the command line
GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)

GLUON_PRIORITY ?= 0
GLUON_LANGS ?= de en 
GLUON_REGION ?= eu
GLUON_ATH10K_MESH ?= 11s
