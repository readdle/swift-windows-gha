setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="devtools" --name="Build Yams" --flag=SW_SKIP_DEVTOOLS_YAMS
if errorlevel 1 exit /b 0

cmake --build %SW_YAMS_BUILD_DIR%

endlocal
