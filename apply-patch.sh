#!/bin/sh

ORG=povray-3.8.0-beta.2
MY=povdump-3.8.0-beta.2
PATCHES_DIR=patches

for _patch in $(find ${PATCHES_DIR} -type f)
do
  #~ echo "Applying ${_patch}"
  #~ patch -p0 -i "${_patch}"
  sed -e '/---/s/\\\\/\//g; /+++/s/\\\\/\//g' "${_patch}" | patch -p0
done
#set PFN=source\base\build.h
#call :make_patch

#set PFN=source\povms\povmsid.h
#call :make_patch

#set PFN=source\frontend\processrenderoptions.cpp
#call :make_patch

#exit /b 0
#:make_patch
#set PATCH_FILE_NAME=%PFN:\=_%.patch
#echo Applying %PATCH_FILE_NAME%
#patch -p0 -i %PATCHES_DIR%\%PATCH_FILE_NAME%
#exit /b 0
