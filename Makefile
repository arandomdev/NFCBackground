THEOS_DEVICE_IP = haotestlabs.com
THEOS_DEVICE_PORT = 28262

ARCHS = arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NFCBackground
NFCBackground_FILES = Tweak.xm NSData+Conversion.m
NFCBackground_FRAMEWORKS = CoreNFC CoreFoundation
NFCBackground_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 nfcd" || true
