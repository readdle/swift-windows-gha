setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="devtools" --name="Install swift-driver" --flag=SW_SKIP_DEVTOOLS_SWIFT_DRIVER
if errorlevel 1 exit /b 0

cmake --build %SW_SWIFT_DRIVER_BUILD_DIR% --target install

endlocal