@echo off
setlocal

set ORG=povray-3.8.0-beta.2
set MY=povdump-3.8.0-beta.2
set PATCHES_DIR=patches

set PFN=source\parser\dump.h
call :make_patch

set PFN=source\parser\dump.cpp
call :make_patch

set PFN=source\base\build.h
call :make_patch

set PFN=vfe\vfe.cpp
call :make_patch

set PFN=source\povms\povmsid.h
call :make_patch

set PFN=source\frontend\processrenderoptions.cpp
call :make_patch

set PFN=source\parser\parser.cpp
call :make_patch

set PFN=windows\vs2015\povparser.vcxproj
call :make_patch

set PFN=source\core\scene\scenedata.h
call :make_patch

set PFN=source\core\scene\scenedata.cpp
call :make_patch

set PFN=source\core\scene\object.h
call :make_patch

set PFN=source\core\scene\object.cpp
call :make_patch

::~ set PFN=source\backend\control\scene.h
::~ call :make_patch

set PFN=source\backend\control\scene.cpp
call :make_patch

exit /b 0
:make_patch
set PATCH_FILE_NAME=%PFN:\=_%.patch
echo Making %PATCH_FILE_NAME%
diff -rupNb %ORG%\%PFN% %MY%\%PFN% > %PATCHES_DIR%\%PATCH_FILE_NAME%
exit /b 0
