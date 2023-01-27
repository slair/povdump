#!/bin/sh

# sources folder
ORG=povray-3.8.0-beta.2

# where build was
MY=povdump-3.8.0-beta.2

# name installed
POVVERSIONSYS=v3.8-beta
#~ POVDUMP_BIN_DIR=POV-Ray/${POVVERSIONSYS}/bin
POVDUMP_BIN_DIR=${HOME}/bin

PATCHES_DIR=patches

# check for sources
if ! [ -d ${MY} ]; then
	echo "CREATING NEW ${MY}"
	sleep 3s
	if ! [ -d ${ORG} ]; then
		if ! [ -f ${ORG}.zip ]; then
			wget -c https://github.com/POV-Ray/povray/archive/refs/tags/v3.8.0-beta.2.zip
			mv v3.8.0-beta.2.zip ${ORG}.zip
		fi
		7z x ${ORG}.zip
	fi

	for _patch in $(find ${PATCHES_DIR} -type f)
	do
	  sed -e '/---/s/\\\\/\//g; /+++/s/\\\\/\//g' "${_patch}" | patch -p0
	done

	mv ${ORG} ${MY}
fi

# let's build them
echo "let's build them"

echo "done"
