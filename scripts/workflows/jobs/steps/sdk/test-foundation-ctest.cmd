setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="sdk" --name="Test Foundation (CTest)" --flag=SW_SKIP_SDK_FOUNDATION_TEST
if errorlevel 1 exit /b 0

cmake --build %SW_FOUNDATION_BUILD_DIR% --target test

if %SW_IGNORE_TEST_FAILURES% neq 0 exit /b 0

endlocal
