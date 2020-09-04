setlocal enabledelayedexpansion

set SW_PUSHDIR=%CD%

if [%SW_SWIFT_BRANCH_SPEC%]==[5.2] (
  cd /d %SW_LLVM_PROJECT_SOURCES_DIR%^
   && git config user.name 'builder'^
   && git config user.email 'builder@lxbndr.org'^
   && git apply --verbose %SW_WORKSPACE%\patch\llvm-project\b288d90b39f4b905c02092a9bfcfd6d78f99b191.patch^
   && git apply --verbose %SW_WORKSPACE%\patch\llvm-project\762d17e112ba90e677daef60fafaa82236f28064_type_traits.patch
)

set SW_ERROR=%ERRORLEVEL%
cd /d %SW_PUSHDIR%

endlocal & exit /b %SW_ERROR%
