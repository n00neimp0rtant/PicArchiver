include theos/makefiles/common.mk

TWEAK_NAME = PicArchiver
PicArchiver_FILES = Tweak.xm ButtonBar.m InnerButtonBar.m
PicArchiver_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

pkg: Tweak.xm ButtonBar.m InnerButtonBar.m
	cp obj/PicArchiver.dylib Layout/Library/MobileSubstrate/DynamicLibraries/PicArchiver.dylib
	cp PicArchiver.plist Layout/Library/MobileSubstrate/DynamicLibraries/PicArchiver.plist
	cp control Layout/DEBIAN/control
	dpkg -b Layout
	mv Layout.deb PicArchiver.deb