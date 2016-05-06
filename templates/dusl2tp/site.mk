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
	gluon-hotfix \
	gluon-txpowerfix \
	gluon-nodinfoplus \
	ffho-autoupdater-wifi-fallback \
	haveged \
	iptables \
	iwinfo \
	gluon-ebtables-filter-roguenets \
        ffffm-keep-radio-channel \
        gluon-banner \
	gluon-migrate-vpn \
	gluon-linkcheck

#ar71xx-generic
GLUON_TLWR1043_SITE_PACKAGES := mod-usb-core kmod-usb2
GLUON_TLWR842_SITE_PACKAGES := mod-usb-core kmod-usb2
GLUON_TLWDR4300_SITE_PACKAGES := mod-usb-core kmod-usb2
GLUON_TLWR2543_SITE_PACKAGES := mod-usb-core kmod-usb2
GLUON_WRT160NL_SITE_PACKAGES := mod-usb-core kmod-usb2
GLUON_DIR825B1_SITE_PACKAGES := mod-usb-core kmod-usb2
GLUON_GLINET_SITE_PACKAGES := mod-usb-core kmod-usb2
GLUON_WNDR3700_SITE_PACKAGES := mod-usb-core kmod-usb2
GLUON_WZRHPG450H_SITE_PACKAGES := mod-usb-core kmod-usb2
GLUON_WZRHPAG300H_SITE_PACKAGES := mod-usb-core kmod-usb2
GLUON_ARCHERC7_SITE_PACKAGES := mod-usb-core kmod-usb2
GLUON_DIR505A1_SITE_PACKAGES := kmod-usb-core kmod-usb2 
#GLUON_DIR505A1_SITE_PACKAGES := kmod-usb-core kmod-usb2 mod-video-core kmod-video-gspca-core kmod-video-gspca-zc3xx kmod-video-uvc kmod-video-videobuf2

#mpc85xx-generic
GLUON_TLWDR4900_SITE_PACKAGES := mod-usb-core kmod-usb2

DEFAULT_GLUON_RELEASE := SBRANCH

# Allow overriding the release number from the command line
GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)

GLUON_PRIORITY ?= 0
GLUON_LANGS ?= de en 
