@echo off

::~ set POVVERSION=

set ORG=povray-3.8.0-beta.2

set MY=povdump-3.8.0-beta.2
set POVDUMP_BIN_DIR=C:\apps\POV-Ray\v3.8-beta\bin

set PATCHES_DIR=patches

if not exist %MY% (
echo CREATING NEW %MY%
sleep 30s
if not exist %ORG% 7z x %ORG%.zip
copy %ORG% %MY%
call apply-patch.cmd
)

pushd %MY%\windows\vs2015

if not defined VSCMD_VER call vcvars64.bat

MSBuild povray.sln /p:Configuration=Release /p:Platform="x64"
if errorlevel 0 goto success
echo ===================
echo ^| BUILD FAILED!!! ^|
echo ===================
::~ play failed sound
goto end

:success

ln bin64/pvengine64.exe c:\apps\POV-Ray\v3.8-beta\bin\povdump64.exe
ln bin64/cmedit64.dll c:\apps\POV-Ray\v3.8-beta\bin\cmedit64.dll

echo BUILD SUCCESSFUL!!!

cd C:\slair\work.local\povray\my-blocks
povdump64.exe /EXIT +NR +Imain.pov

:end
popd
