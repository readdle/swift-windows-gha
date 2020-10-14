setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="devtools" --name="Install swift-package-manager" --flag=SW_SKIP_DEVTOOLS_SPM
if errorlevel 1 exit /b 0

cmake --build %SW_SPM_BUILD_DIR% --target install

endlocal
