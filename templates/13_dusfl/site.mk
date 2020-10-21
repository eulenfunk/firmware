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
        mesh-vpn-tunneldigger \
	status-page\

# eulenfunk:
GLUON_SITE_PACKAGES := \
        respondd-module-airtime \
        gluon-weeklyreboot \
        eulenfunk-hotfix \
        gluon-txpowerfix \
        gluon-banner \
        gluon-linkcheck \
        gluon-config-mode-geo-location-osm \
        gluon-authorized-keys \
        eulenfunk-migrate-updatebranch \
        eulenfunk-ath9kblackout

# ffffm 
# ev. kann man ffffm-additional-wifi-json-info teilweise durch standard gluon respondd-module-airtime ersetzen
GLUON_SITE_PACKAGES += \
	ffffm-keep-radio-channel \
	ffffm-button-bind 

# ffki:
GLUON_SITE_PACKAGES += \
	gluon-config-mode-ppa \

# ffnord:
GLUON_SITE_PACKAGES += \
	gluon-ssid-changer 

# openwrt:
GLUON_SITE_PACKAGES += \
	iptables \
	iwinfo \
	socat \
        kmod-sched \
        libc \
        libpthread \
        librt

ifeq ($(GLUON_TARGET),ar71xx-tiny)
GLUON_SITE_PACKAGES += zram-swap
endif

ifeq ($(GLUON_TARGET),ar71xx-generic)
GLUON_SITE_PACKAGES += zram-swap
endif

USB_BASIC := \
	kmod-usb-core \
	kmod-usb2 \
	kmod-usb-hid

USB_NIC := \
	kmod-usb-net \
	kmod-usb-net-asix \
	kmod-usb-net-rtl8150 \
	kmod-usb-net-rtl8152 \
	kmod-usb-net-dm9601-ether

USB_WIFI := \
	kmod-rtl8192cu

ifeq ($(GLUON_TARGET),x86-generic)
	GLUON_SITE_PACKAGES += \
		$(USB_BASIC) \
		kmod-usb-ohci-pci \
		$(USB_NIC)
endif

ifeq ($(GLUON_TARGET),x86-64)
	GLUON_SITE_PACKAGES += \
		$(USB_BASIC) \
		$(USB_NIC) \
		kmod-igb #APU2
endif

ifeq ($(GLUON_TARGET),brcm2708-bcm2708)
	GLUON_SITE_PACKAGES += \
		$(USB_BASIC) \
		$(USB_NIC) \
		$(USB_WIFI)
endif

ifeq ($(GLUON_TARGET),brcm2708-bcm2709)
	GLUON_SITE_PACKAGES += \
		$(USB_BASIC) \
		$(USB_NIC) \
		$(USB_WIFI)
endif


DEFAULT_GLUON_RELEASE := SBRANCH

# Allow overriding the release number from the command line
GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)

GLUON_PRIORITY ?= 0
GLUON_LANGS ?= de en 
GLUON_REGION ?= eu
GLUON_ATH10K_MESH ?= 11s
GLUON_WLAN_MESH ?= 11s
GLUON_DEPRECATED ?= full
GLUON_MULTIDOMAIN=0