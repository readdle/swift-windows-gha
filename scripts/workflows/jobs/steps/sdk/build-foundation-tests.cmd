setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="sdk" --name="Build Foundation Tests" --flag=SW_SKIP_SDK_FOUNDATION_TEST
if errorlevel 1 exit /b 0

cmake --build %SW_FOUNDATION_BUILD_DIR%-test

endlocal
