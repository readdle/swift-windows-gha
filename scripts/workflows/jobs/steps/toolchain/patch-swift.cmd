setlocal

set SW_LOG_PATCH_INFO=%SW_LOG_INFO% --scope patch-swift
set SW_LOG_PATCH_ERROR=%SW_LOG_ERROR% --scope patch-swift

set SW_PATCH_DISABLE_OBJC=%SW_WORKSPACE%\patch\swift\disable-objc-%SW_SWIFT_BRANCH_SPEC%.patch

if [%SW_OBJC_PATCH_ENABLED%]==[YES] (
  %SW_LOG_PATCH_INFO% --message="Will apply %SW_PATCH_DISABLE_OBJC%"
  set SW_PATCH_DISABLE_OBJC=git apply --verbose %SW_PATCH_DISABLE_OBJC%
) else (
  %SW_LOG_PATCH_INFO% --message="Will NOT apply %SW_PATCH_DISABLE_OBJC%"
  set SW_PATCH_DISABLE_OBJC=echo.
)

set SW_PUSHDIR=%CD%

cd /d %SW_SWIFT_SOURCES_DIR%^
 && git config user.name 'builder'^
 && git config user.email 'builder@lxbndr.org'^
 && %SW_PATCH_DISABLE_OBJC%

set SW_ERROR=%ERRORLEVEL%
cd /d %SW_PUSHDIR%

endlocal & exit /b %SW_ERROR%
