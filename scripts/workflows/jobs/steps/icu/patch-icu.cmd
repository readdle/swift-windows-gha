setlocal enabledelayedexpansion

goto :eof

set SW_PUSHDIR=%CD%

cd /d %SW_ICU_SOURCES_DIR%^
 && git config user.name 'builder'^
 && git config user.email 'swift-builder@readdle.com'^
 && git apply %SW_WORKSPACE%\patch\icu\715d254a02b0b22681cb6f861b0921ae668fa7d6.patch

set SW_ERROR=%ERRORLEVEL%
cd /d %SW_PUSHDIR%

endlocal & exit /b %SW_ERROR%
