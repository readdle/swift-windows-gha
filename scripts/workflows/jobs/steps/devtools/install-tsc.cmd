setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="devtools" --name="Install swift-tools-support-core" --flag=SW_SKIP_DEVTOOLS_TSC
if errorlevel 1 exit /b 0

cmake --build %SW_TSC_BUILD_DIR% --target install

endlocal
