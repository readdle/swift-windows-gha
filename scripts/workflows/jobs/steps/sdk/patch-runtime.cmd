@echo on

setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="sdk" --name="Patch Runtime" --flag=SW_SKIP_SDK_CHECKOUT
if errorlevel 1 exit /b 0

set SW_PUSHDIR=%CD%

set SW_LOG_PATCH_INFO=%SW_LOG_INFO% --scope patch-runtime
set SW_LOG_PATCH_ERROR=%SW_LOG_ERROR% --scope patch-runtime

set SW_PATCH_PRINT_FLUSH=%SW_WORKSPACE%\patch\swift\runtime\print-flush-%SW_SWIFT_BRANCH_SPEC%.patch
set SW_PATCH_INSTALL_PDB=%SW_WORKSPACE%\patch\swift\runtime\install-pdb.patch
set SW_PATCH_PRINT_BACKTRACE=%SW_WORKSPACE%\patch\swift\runtime\print-backtrace-%SW_SWIFT_BRANCH_SPEC%.patch

if [%SW_RUNTIME_PATCH_ENABLED%]==[YES] (
  %SW_LOG_PATCH_INFO% --message="Will apply %SW_PATCH_PRINT_FLUSH%"
  set SW_PATCH_PRINT_FLUSH=git apply --verbose %SW_PATCH_PRINT_FLUSH%
) else (
  %SW_LOG_PATCH_INFO% --message="Will NOT apply %SW_PATCH_PRINT_FLUSH%"
  set SW_PATCH_PRINT_FLUSH=echo.
)

if [%SW_SWIFT_SDK_SPEC%]==[readdle] (
  %SW_LOG_PATCH_INFO% --message="Will apply %SW_PATCH_INSTALL_PDB%"
  set SW_PATCH_INSTALL_PDB=git apply --verbose %SW_PATCH_INSTALL_PDB%
  %SW_LOG_PATCH_INFO% --message="Will apply %SW_PATCH_PRINT_BACKTRACE%"
  set SW_PATCH_PRINT_BACKTRACE=git apply --verbose %SW_PATCH_PRINT_BACKTRACE%
) else (
  %SW_LOG_PATCH_INFO% --message="Will NOT apply %SW_PATCH_INSTALL_PDB%"
  set SW_PATCH_INSTALL_PDB=echo.
  %SW_LOG_PATCH_INFO% --message="Will NOT apply %SW_PATCH_PRINT_BACKTRACE%"
  set SW_PATCH_PRINT_BACKTRACE=echo.
)

%SW_LOG_PATCH_INFO% --message="Working in %SW_SWIFT_SOURCES_DIR%"

cd /d %SW_SWIFT_SOURCES_DIR%^
 && git config user.name 'builder'^
 && git config user.email 'swift-builder@readdle.com'^
 && %SW_PATCH_PRINT_FLUSH%^
 && %SW_PATCH_INSTALL_PDB%^
 && %SW_PATCH_PRINT_BACKTRACE%

set SW_ERROR=%ERRORLEVEL%

%SW_LOG_PATCH_INFO% --message="Restoring original working directory %SW_PUSHDIR%"
cd /d %SW_PUSHDIR%

if not %SW_ERROR% equ 0 %SW_LOG_PATCH_ERROR% --message="Patch failed"

endlocal & exit /b %SW_ERROR%
