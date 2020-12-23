setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="sdk" --name="Configure Foundation Test Environment" --flag=SW_SKIP_SDK_FOUNDATION_TEST
if errorlevel 1 exit /b 0

endlocal

%SW_SET_ENV% PATH "%SW_ICU_DIR%\usr\bin;%SW_STDLIB_BUILD_DIR%\bin;%SW_DISPATCH_BUILD_DIR%;%SW_FOUNDATION_BUILD_DIR%\Foundation;%SW_XCTEST_BUILD_DIR%;%PATH%;%ProgramFiles%\Git\usr\bin"
