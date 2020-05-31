setlocal

if %SW_ICU_VERSION% leq 64 goto :eof

pushd %CD%

cd %SW_ICU_SOURCES_DIR%^
 && git config user.name 'builder'^
 && git config user.email 'builder@lxbndr.org'^
 && git apply %SW_WORKSPACE%\patch\icu\uassert.patch

set SW_ERROR=%ERRORLEVEL%
popd

endlocal & exit /b %SW_ERROR%
