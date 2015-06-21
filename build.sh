#!/bin/bash -ex

make clean

# FEEDS
./scripts/feeds uninstall -a
rm -rf feeds
./scripts/feeds update -a
./scripts/feeds install -a

# DELETE PACKAGES
rm -rf ./package/feeds/packages/avrdude
rm -rf ./package/feeds/packages/rng-tools

# LINK CUSTOM PACKAGES
ln -s ../../../feeds/arduino/avrdude ./package/feeds/arduino/avrdude
ln -s ../../../feeds/arduino/rng-tools ./package/feeds/arduino/rng-tools

# CONFIG
if [ "$BUILD_BASE_ONLY" = "Yes" ]; then
	rm -f .config
	cp config.default .config
else
	rm -f .config
	cp config.yun .config	
fi

make oldconfig

make
