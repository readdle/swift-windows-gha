setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="sdk" --name="Install XCTest" --flag=SW_SKIP_SDK_XCTEST
if errorlevel 1 exit /b 0

cmake --build %SW_XCTEST_BUILD_DIR% --target install

endlocal
