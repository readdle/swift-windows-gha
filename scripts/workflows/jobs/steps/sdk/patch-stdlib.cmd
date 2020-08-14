setlocal

set SW_PUSHDIR=%CD%

set SW_LOG_PATCH_INFO=%SW_LOG_INFO% --scope patch-stdlib
set SW_LOG_PATCH_ERROR=%SW_LOG_ERROR% --scope patch-stdlib

set SW_PRINT_FLUSH_PATCH=%SW_WORKSPACE%\patch\swift\stdlib\print-flush-%SW_SWIFT_BRANCH_SPEC%.patch
set SW_INSTALL_PDB_PATCH=%SW_WORKSPACE%\patch\swift\stdlib\install-pdb.patch
set SW_PRINT_BACKTRACE_PATCH=%SW_WORKSPACE%\patch\swift\stdlib\print-backtrace.patch

if [%SW_STDLIB_PATCH_ENABLED%]==[YES] (
  %SW_LOG_PATCH_INFO% --message="Will apply %SW_PRINT_FLUSH_PATCH%"
  set SW_PRINT_FLUSH_PATCH=git apply --verbose %SW_PRINT_FLUSH_PATCH%
) else (
  %SW_LOG_PATCH_INFO% --message="Will NOT apply %SW_PRINT_FLUSH_PATCH%"
  set SW_PRINT_FLUSH_PATCH=echo .
)

if [%SW_SWIFT_SDK_SPEC%]==[readdle] (
  %SW_LOG_PATCH_INFO% --message="Will apply %SW_INSTALL_PDB_PATCH%"
  set SW_INSTALL_PDB_PATCH=git apply --verbose %SW_INSTALL_PDB_PATCH%
  %SW_LOG_PATCH_INFO% --message="Will apply %SW_PRINT_BACKTRACE_PATCH%"
  set SW_PRINT_BACKTRACE_PATCH=git apply --verbose %SW_PRINT_BACKTRACE_PATCH%
) else (
  %SW_LOG_PATCH_INFO% --message="Will NOT apply %SW_INSTALL_PDB_PATCH%"
  set SW_INSTALL_PDB_PATCH=echo .
  %SW_LOG_PATCH_INFO% --message="Will NOT apply %SW_PRINT_BACKTRACE_PATCH%"
  set SW_PRINT_BACKTRACE_PATCH=echo .
)

%SW_LOG_PATCH_INFO% --message="Working in %SW_SWIFT_SOURCES_DIR%"

cd /d %SW_SWIFT_SOURCES_DIR%^
 && git config user.name 'builder'^
 && git config user.email 'builder@lxbndr.org'^
 && %SW_PRINT_FLUSH_PATCH%^
 && %SW_INSTALL_PDB_PATCH%^
 && %SW_PRINT_BACKTRACE_PATCH%

set SW_ERROR=%ERRORLEVEL%

%SW_LOG_PATCH_INFO% --message="Restoring original working directory %SW_PUSHDIR%"
cd /d %SW_PUSHDIR%

if not %SW_ERROR% equ 0 %SW_LOG_PATCH_ERROR% --message="Patch failed"

endlocal & exit /b %SW_ERROR%