ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NFCBackground
NFCBackground_FILES = Tweak.xm NSData+Conversion.m
NFCBackground_FRAMEWORKS = CoreNFC CoreFoundation
NFCBackground_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 nfcd" || true
