setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="sdk" --name="Test Foundation (CTest)" --flag=SW_SKIP_SDK_FOUNDATION_TEST
if errorlevel 1 exit /b 0

cmake --build %SW_FOUNDATION_BUILD_DIR%-test --target test

if errorlevel 1 (
  %SW_LOG_WARNING% --scope="sdk" --message="Foundation test (CTest) failed"
)
exit /b 0

endlocal
