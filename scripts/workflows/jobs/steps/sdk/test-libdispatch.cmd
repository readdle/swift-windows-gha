setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="sdk" --name="Test libdispatch" --flag=SW_SKIP_SDK_DISPATCH_TEST
if errorlevel 1 exit /b 0

cmake --build %SW_DISPATCH_BUILD_DIR%-test --target ExperimentalTest

if errorlevel 1 (
  %SW_LOG_WARNING% --scope="sdk" --message="libdispatch test failed"
)
exit /b 0

endlocal
