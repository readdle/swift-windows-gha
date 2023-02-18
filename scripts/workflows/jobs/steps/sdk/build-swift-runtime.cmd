setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="sdk" --name="Build Runtime" --flag=SW_SKIP_SDK_RUNTIME
if errorlevel 1 exit /b 0

cmake --build %SW_RUNTIME_BUILD_DIR%

endlocal
