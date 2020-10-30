setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="sdk" --name="Test Foundation (XCTest)" --flag=SW_SKIP_SDK_FOUNDATION_TEST
if errorlevel 1 exit /b 0

%SW_FOUNDATION_BUILD_DIR%\TestFoundation.app\TestFoundation.exe

if errorlevel 1 (
  %SW_LOG_WARNING% --scope="sdk" --message="Foundation test (XCTest) failed"
)
exit /b 0

endlocal
