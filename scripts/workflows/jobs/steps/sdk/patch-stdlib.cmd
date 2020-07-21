if not [%SW_STDLIB_PATCH_ENABLED%]==[YES] (
    echo Skipping StdLib patches
    goto :eof
)

setlocal

set SW_PUSHDIR=%CD%

cd /d %SW_SWIFT_SOURCES_DIR%^
 && git config user.name 'builder'^
 && git config user.email 'builder@lxbndr.org'^
 && git apply --verbose %SW_WORKSPACE%\patch\swift\stdlib\print-flush.patch

set SW_ERROR=%ERRORLEVEL%
cd /d %SW_PUSHDIR%

endlocal & exit /b %SW_ERROR%