#!/bin/sh

# sources folder
ORG=povray-3.8.0-beta.2

# name installed
POVVERSIONSYS=v3.8-beta
POVDUMP_BIN_DIR=POV-Ray/${POVVERSIONSYS}/bin

# where build was
MY=povdump-3.8.0-beta.2

PATCHES_DIR=patches

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
	. ./apply-patch.sh
	mv ${ORG} ${MY}
fi

#~ call make-patch.cmd

#~ pushd %MY%\windows\vs2015

#~ if not defined VSCMD_VER call vcvars64.bat
#~ del bin64\pvengine64.exe > NUL 2>&1
#~ del bin64\cmedit64.dll > NUL 2>&1
#~ MSBuild povray.sln -p:Configuration=Release -p:Platform="x64" -nologo

#~ del %POVDUMP_BIN_DIR%\povdump64.exe > NUL 2>&1
#~ ln bin64/pvengine64.exe %POVDUMP_BIN_DIR%\povdump64.exe > NUL 2>&1

#~ del %POVDUMP_BIN_DIR%\cmedit64.dll > NUL 2>&1
#~ ln bin64/cmedit64.dll %POVDUMP_BIN_DIR%\cmedit64.dll > NUL 2>&1

#~ popd

#~ echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
#~ call :povdump_test result !C:\slair\work.local\povdump\test.pov!
#~ echo ³ %result%
#~ echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#~ if %result%==failed goto :failed

#~ echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
#~ call :povdump_test result !C:\slair\work.local\povray\my-blocks\main.pov!
#~ echo ³ %result%
#~ echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#~ if %result%==failed goto :failed

#~ :ok
#~ echo   _____________ ____________ _________ ___________ _________ ________________________ ___.____
#~ echo  /   _____/    ³   \_   ___ \\_   ___ \\_   _____//   _____//   _____/\_   _____/    ³   \    ³
#~ echo  \_____  \³    ³   /    \  \//    \  \/ ³    __)_ \_____  \ \_____  \  ³    __) ³    ³   /    ³
#~ echo  /        \    ³  /\     \___\     \____³        \/        \/        \ ³     \  ³    ³  /³    ³___
#~ echo /_______  /______/  \______  /\______  /_______  /_______  /_______  / \___  /  ³______/ ³_______ \
#~ echo         \/                 \/        \/        \/        \/        \/      \/                    \/
#~ echo.
#~ mpv.com %HOME%\share\sounds\jingl-victory.mp3 > NUL 2>&1
#~ goto :end
#~ :failed
#~ echo.
#~ echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
#~ echo ³ BUILD FAILED ³
#~ echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#~ mpv.com %HOME%\share\sounds\trombone-sad.wav > NUL 2>&1
#~ goto :end
#~ :povdump_test  <resultVar> <pathVar>
#~ set POVDUMP_TEST_DIR=%~dp2
#~ set POVDUMP_TEST_FILE=%~nx2
#~ echo Testing '%POVDUMP_TEST_FILE%' in '%POVDUMP_TEST_DIR%'

#~ pushd %POVDUMP_TEST_DIR%
#~ del scene.dump > NUL 2>&1
#~ del povdump.log > NUL 2>&1

#~ if exist %POVDUMP_BIN_DIR%\povdump64.exe (
#~ povdump64.exe /EXIT +NRE +I%POVDUMP_TEST_FILE%
#~ if exist scene.dump (
#~ head -c256 scene.dump | hexdump.lua
#~ ::~ type povdump.log
#~ tail -n10 povdump.log
#~ set "%~1=ok"
#~ popd
#~ exit /b
#~ )
#~ set "%~1=failed"
#~ popd
#~ exit /b
#~ )
#~ set "%~1=failed"
#~ popd
#~ exit /b

#~ :end
#~ echo.
