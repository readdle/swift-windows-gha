setlocal

pushd %CD%

if [%SW_SWIFT_BRANCH_SPEC%]==[5.2] (
  echo Working in %SW_LLVM_PROJECT_SOURCES_DIR%
  cd %SW_LLVM_PROJECT_SOURCES_DIR%^
   && git config user.name 'builder'^
   && git config user.email 'builder@lxbndr.org'^
   && git apply --verbose %SW_WORKSPACE%\patch\llvm-project\b288d90b39f4b905c02092a9bfcfd6d78f99b191.patch
)

set SW_ERROR=%ERRORLEVEL%
popd

endlocal & exit /b %SW_ERROR%
