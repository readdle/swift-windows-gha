if [%SW_EXPERIMENTAL_OBJC_PATCH_ENABLED%]==[NO] (
    echo Skipping Foundation tests
    goto :eof
)

setlocal

set SW_PUSHDIR=%CD%

cd /d %SW_SWIFT_SOURCES_DIR%^
 && git config user.name 'builder'^
 && git config user.email 'builder@lxbndr.org'^
 && git apply --verbose %SW_WORKSPACE%\patch\swift\disable-objc.patch

set SW_ERROR=%ERRORLEVEL%
cd /d %SW_PUSHDIR%

endlocal & exit /b %SW_ERROR%
