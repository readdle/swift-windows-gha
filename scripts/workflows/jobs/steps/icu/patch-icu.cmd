setlocal

pushd %CD%

git config user.name 'builder'^
 && git config user.email 'builder@lxbndr.org'^
 && git apply %SW_WORKSPACE%\patch\icu\uassert.patch

set SW_ERROR=%ERRORLEVEL%
popd

endlocal & exit /b %SW_ERROR%
