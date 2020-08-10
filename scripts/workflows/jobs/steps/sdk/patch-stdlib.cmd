setlocal

set SW_PUSHDIR=%CD%

if [%SW_STDLIB_PATCH_ENABLED%]==[YES] (
  echo Applying print-flush.patch
  set SW_PRINT_FLUSH_PATCH=git apply --verbose %SW_WORKSPACE%\patch\swift\stdlib\print-flush.patch
) else (
  echo Skipping print-flush.patch
  set SW_PRINT_FLUSH_PATCH=echo .
)

if [%SW_SWIFT_SDK_SPEC%]==[readdle] (
  echo Applying install-pdb.patch
  set SW_INSTALL_PDB_PATCH=git apply --verbose %SW_WORKSPACE%\patch\swift\stdlib\install-pdb.patch
) else (
  echo Skipping install-pdb.patch
  set SW_INSTALL_PDB_PATCH=echo .
)

cd /d %SW_SWIFT_SOURCES_DIR%^
 && git config user.name 'builder'^
 && git config user.email 'builder@lxbndr.org'^
 && %SW_PRINT_FLUSH_PATCH%^
 && %SW_INSTALL_PDB_PATCH%

set SW_ERROR=%ERRORLEVEL%
cd /d %SW_PUSHDIR%

endlocal & exit /b %SW_ERROR%