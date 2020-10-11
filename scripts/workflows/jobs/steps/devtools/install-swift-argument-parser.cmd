setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="devtools" --name="Install swift-arguments-parser" --flag=SW_SKIP_DEVTOOLS_SAP
if errorlevel 1 exit /b 0

cmake --build %SW_SAP_BUILD_DIR% --target install

endlocal