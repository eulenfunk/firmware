GLUON_SITE_PACKAGES := \
	gluon-mesh-batman-adv-15 \
	gluon-respondd \
	gluon-autoupdater \
	gluon-config-mode-autoupdater \
	gluon-config-mode-contact-info \
	gluon-config-mode-core \
	gluon-config-mode-geo-location \
	gluon-config-mode-hostname \
	gluon-config-mode-tunneldigger \
	gluon-ebtables-filter-multicast \
	gluon-ebtables-filter-ra-dhcp \
	gluon-luci-admin \
	gluon-luci-autoupdater \
	gluon-luci-portconfig \
	gluon-luci-wifi-config \
	gluon-next-node \
	gluon-mesh-vpn-tunneldigger \
	gluon-tunneldigger-watchdog \
	gluon-radvd \
	gluon-setup-mode \
	gluon-status-page \
	gluon-weeklyreboot \
	gluon-ssid-changer \
	gluon-aptimeclock \
	gluon-vpnlimittimeclock \
	gluon-txpowerfix \
	haveged \
	iptables \
	iwinfo \
	gluon-ebtables-filter-roguenets \
        ffffm-keep-radio-channel \
        gluon-banner \
	gluon-migrate-vpn \
	gluon-linkcheck

DEFAULT_GLUON_RELEASE := SBRANCH

# Allow overriding the release number from the command line
GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)

GLUON_PRIORITY ?= 0
GLUON_LANGS ?= de en 
