setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="sdk" --name="Build libdispatch Tests" --flag=SW_SKIP_SDK_DISPATCH_TEST
if errorlevel 1 exit /b 0

cmake --build %SW_DISPATCH_BUILD_DIR%-test

endlocal
