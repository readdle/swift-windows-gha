if not [%SW_OBJC_PATCH_ENABLED%]==[YES] (
    echo Skipping Swift patches
    goto :eof
)

setlocal

if [%SW_SWIFT_BRANCH_SPEC%]==[5.2] (
  set SW_PATCH_CONDITIONAL_EXPLCIT=git apply --verbose %SW_WORKSPACE%\patch\swift\21a4b135529dc83efb4065333e12328c1b77054a.patch
) else (
  set SW_PATCH_CONDITIONAL_EXPLCIT=echo.
)

set SW_PUSHDIR=%CD%

cd /d %SW_SWIFT_SOURCES_DIR%^
 && git config user.name 'builder'^
 && git config user.email 'builder@lxbndr.org'^
 && git apply --verbose %SW_WORKSPACE%\patch\swift\disable-objc-%SW_SWIFT_BRANCH_SPEC%.patch^
 && %SW_PATCH_CONDITIONAL_EXPLCIT%

set SW_ERROR=%ERRORLEVEL%
cd /d %SW_PUSHDIR%

endlocal & exit /b %SW_ERROR%
