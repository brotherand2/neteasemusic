THEOS_DEVICE_IP = 127.0.0.1
THEOS_DEVICE_PORT = 2222
ARCHS =  arm64
TARGET = iphone:latest:7.0
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = neteasemusic
neteasemusic_FILES =  $(wildcard src/*.m) $(wildcard src/*.xm)
neteasemusic_CFLAGS = -fobjc-arc
neteasemusic_OBJCFLAGS = -Wno-error


include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 neteasemusic"
