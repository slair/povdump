@echo off

:: sources folder
set ORG=povray-3.8.0-beta.2

:: name installed
set POVVERSIONSYS=v3.8-beta
set POVDUMP_BIN_DIR=C:\apps\POV-Ray\%POVVERSIONSYS%\bin

:: where build was
set MY=povdump-3.8.0-beta.2

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

del c:\apps\POV-Ray\%POVVERSIONSYS%\bin\povdump64.exe > NUL
ln bin64/pvengine64.exe c:\apps\POV-Ray\%POVVERSIONSYS%\bin\povdump64.exe

del c:\apps\POV-Ray\%POVVERSIONSYS%\bin\cmedit64.dll > NUL
ln bin64/cmedit64.dll c:\apps\POV-Ray\%POVVERSIONSYS%\bin\cmedit64.dll

echo BUILD SUCCESSFUL!!!

povdump64.exe /EXIT +NR +Itest.pov

:end
popd
