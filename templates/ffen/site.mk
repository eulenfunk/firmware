GLUON_FEATURES := \
	autoupdater \
	ebtables-filter-multicast \
	ebtables-filter-ra-dhcp \
	mesh-batman-adv-14 \
	mesh-vpn-tunneldigger \
	radvd \
	respondd \
	status-page \
	web-advanced \
	web-private-wifi \
	web-wizard

GLUON_SITE_PACKAGES := \
	iwinfo \
	gluon-ssid-changer \
	ff-wtbg-autoreboot \
	gluon-tunneldigger-watchdog \
	gluon-quickfix \
	gluon-txpowerfix \
	ffffm-keep-radio-channel \
	haveged

# support the USB stack
USB_PACKAGES_BASIC := \
	kmod-usb-core \
	kmod-usb2

# FAT32 Support for USB
USB_PACKAGES_STORAGE := \
	block-mount \
	kmod-fs-ext4 \
	kmod-fs-vfat \
	kmod-usb-storage  \
	kmod-usb-storage-extras  \
	blkid  \
	swap-utils  \
	kmod-nls-cp1250  \
	kmod-nls-cp1251  \
	kmod-nls-cp437  \
	kmod-nls-cp775  \
	kmod-nls-cp850  \
	kmod-nls-cp852  \
	kmod-nls-cp866  \
	kmod-nls-iso8859-1  \
	kmod-nls-iso8859-13  \
	kmod-nls-iso8859-15  \
	kmod-nls-iso8859-2  \
	kmod-nls-koi8r  \
	kmod-nls-utf8

USB_PACKAGES_NET := \
	kmod-usb-net \
	kmod-usb-net-asix \
	kmod-usb-net-asix-ax88179 \
	kmod-usb-net-cdc-eem \
	kmod-usb-net-cdc-ether \
	kmod-usb-net-cdc-mbim \
	kmod-usb-net-cdc-ncm \
	kmod-usb-net-cdc-subset \
	kmod-usb-net-dm9601-ether \
	kmod-usb-net-hso \
	kmod-usb-net-huawei-cdc-ncm \
	kmod-usb-net-ipheth \
	kmod-usb-net-kalmia \
	kmod-usb-net-kaweth \
	kmod-usb-net-mcs7830 \
	kmod-usb-net-pegasus \
	kmod-usb-net-qmi-wwan \
	kmod-usb-net-rndis \
	kmod-usb-net-rtl8150 \
	kmod-usb-net-rtl8152 \
	kmod-usb-net-sierrawireless \
	kmod-usb-net-smsc95xx \
	kmod-mii \
	kmod-nls-base

TOOLS_PACKAGES := \
	joe \
	tcpdump \
	vnstat \
	iperf \
	iperf3 \
	socat \
	usbutils


ifeq ($(GLUON_TARGET),x86-generic)
# support the usb stack on x86 devices
# and add a few common USB NICs
GLUON_SITE_PACKAGES += \
	kmod-usb-hid \
	$(USB_PACKAGES_BASIC) \
	$(USB_PACKAGES_STORAGE) \
	$(USB_PACKAGES_NET) \
	$(TOOLS_PACKAGES)
endif

#ar71xx-generic
GLUON_DIR505A1_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(TOOLS_PACKAGES) $(USB_PACKAGES_STORAGE)
GLUON_TLWR842_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(TOOLS_PACKAGES) $(USB_PACKAGES_STORAGE)
GLUON_TLWR1043_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(TOOLS_PACKAGES) $(USB_PACKAGES_STORAGE)
GLUON_TLWR2543_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(TOOLS_PACKAGES) $(USB_PACKAGES_STORAGE)
GLUON_TLWDR4300_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(TOOLS_PACKAGES) $(USB_PACKAGES_STORAGE)
GLUON_WNDR3700_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(TOOLS_PACKAGES) $(USB_PACKAGES_STORAGE)
GLUON_WRT160NL_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(TOOLS_PACKAGES) $(USB_PACKAGES_STORAGE)
# GLUON_DIR825B1_SITE_PACKAGES := kmod-usb-core kmod-usb2 tcpdump vnstat iperf usbutils joe kmod-mii kmod-usb-net kmod-usb-net-asix-ax88179 kmod-usb-net kmod-nls-base # too big
GLUON_GLINET_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(TOOLS_PACKAGES) $(USB_PACKAGES_STORAGE)
GLUON_WZRHPG450H_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(TOOLS_PACKAGES) $(USB_PACKAGES_STORAGE)
GLUON_WZRHPAG300H_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(TOOLS_PACKAGES) $(USB_PACKAGES_STORAGE)
GLUON_ARCHERC7_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(TOOLS_PACKAGES) $(USB_PACKAGES_STORAGE)

#mpc85xx-generic
GLUON_TLWDR4900_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(TOOLS_PACKAGES) $(USB_PACKAGES_STORAGE)


DEFAULT_GLUON_RELEASE := 0.9.5

GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)

GLUON_PRIORITY ?= 0

GLUON_REGION ?= eu

GLUON_LANGS ?= de en

GLUON_MULTIDOMAIN=0

GLUON_WLAN_MESH ?= 11s
