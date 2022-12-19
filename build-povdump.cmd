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

call make-patch.cmd

del %MY%\windows\vs2015\bin64\pvengine64.exe > NUL 2>&1
del %MY%\windows\vs2015\bin64\cmedit64.dll > NUL 2>&1

pushd %MY%\windows\vs2015

if not defined VSCMD_VER call vcvars64.bat
MSBuild povray.sln /p:Configuration=Release /p:Platform="x64"

del %POVDUMP_BIN_DIR%\povdump64.exe > NUL 2>&1
ln bin64/pvengine64.exe %POVDUMP_BIN_DIR%\povdump64.exe > NUL 2>&1

del %POVDUMP_BIN_DIR%\cmedit64.dll > NUL 2>&1
ln bin64/cmedit64.dll %POVDUMP_BIN_DIR%\cmedit64.dll > NUL 2>&1

popd

del scene.dump > NUL 2>&1
del povdump.log > NUL 2>&1

if exist %POVDUMP_BIN_DIR%\povdump64.exe (
povdump64.exe /EXIT +NR +Itest.pov
type scene.dump | xd.lua
type povdump.log
)

if not exist scene.dump (
echo.
echo ===================
echo ^| BUILD FAILED!!! ^|
echo ===================
::~ play failed sound
goto :end
)

echo.
echo BUILD SUCCESSFUL!!!

:end
