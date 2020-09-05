setlocal enabledelayedexpansion

:: No patches for LLVM yet
goto :eof

set SW_PUSHDIR=%CD%

cd /d %SW_LLVM_PROJECT_SOURCES_DIR%^
 && git config user.name 'builder'^
 && git config user.email 'builder@lxbndr.org'^
 && git apply --verbose XXX.patch

set SW_ERROR=%ERRORLEVEL%
cd /d %SW_PUSHDIR%

endlocal & exit /b %SW_ERROR%
