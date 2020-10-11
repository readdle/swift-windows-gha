setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="devtools" --name="Build swift-package-manager" --flag=SW_SKIP_DEVTOOLS_SPM
if errorlevel 1 exit /b 0

cmake --build %SW_SPM_BUILD_DIR%

endlocal
