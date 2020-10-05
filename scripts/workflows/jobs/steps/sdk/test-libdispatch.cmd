setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="sdk" --name="Test libdispatch" --flag=SW_SKIP_SDK_DISPATCH_TEST
if errorlevel 1 exit /b 0

cmake --build %SW_DISPATCH_BUILD_DIR% --target ExperimentalTest

if %SW_IGNORE_TEST_FAILURES% neq 0 exit /b 0

endlocal
