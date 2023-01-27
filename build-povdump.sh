#!/bin/sh

# sources folder
ORG=povray-3.8.0-beta.2

# where build was
MY=povdump-3.8.0-beta.2

# name installed
POVVERSIONSYS=v3.8-beta
#~ POVDUMP_BIN_DIR=POV-Ray/${POVVERSIONSYS}/bin
POVDUMP_BIN_DIR=${HOME}/bin

POVRAY_COMPILED_BY="enter_your_name <mail@host>"

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

cd ${MY}

set +u
if [ -z "$ARCH" ]; then
  case "$( uname -m )" in
    i?86) ARCH=i486 ;;
    arm*) ARCH=arm ;;
       *) ARCH=$( uname -m ) ;;
  esac
fi
set -u
# povray prefers -O3 to build, so we do not use the -O2 flag
if [ "$ARCH" = "i486" ]; then
  SLKCFLAGS="-march=i486 -mtune=i686"
  LIBDIRSUFFIX=""
  BINNAME="povdump"
elif [ "$ARCH" = "i686" ]; then
  SLKCFLAGS="-march=i686 -mtune=i686"
  LIBDIRSUFFIX=""
  BINNAME="povdump"
elif [ "$ARCH" = "x86_64" ]; then
  SLKCFLAGS="-fPIC"
  LIBDIRSUFFIX="64"
  BINNAME="povdump64"
else
  SLKCFLAGS="-O2"
  LIBDIRSUFFIX=""
  BINNAME="povdump"
fi

cd unix
sh ./prebuild.sh

echo "Configuring..."
CXXFLAGS="${SLKCFLAGS}" \
./configure \
--prefix=/usr \
--libdir=/usr/lib${LIBDIRSUFFIX} \
--sysconfdir=/etc \
--localstatedir=/var \
--mandir=/usr/man \
--build=$ARCH-slackware-linux \
LIBS="-lboost_system -lboost_thread" \
COMPILED_BY="${POVRAY_COMPILED_BY}"

echo "Making..."
make -s -j2
#~ cd unix
mv povray ${BINNAME}

echo "done"
