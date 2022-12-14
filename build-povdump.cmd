@echo off

set ORG=povray-3.8.0-beta.2
set MY=povdump-3.8.0-beta.2
set PATCHES_DIR=patches

if not exist %MY% (
if not exist %ORG% 7z x %ORG%.zip
copy %ORG% %MY%
call apply-patch.cmd
)

pushd %MY%\windows\vs2015

if not defined VSCMD_VER call vcvars64.bat

MSBuild povray.sln /p:Configuration=Release /p:Platform="x64"

popd
