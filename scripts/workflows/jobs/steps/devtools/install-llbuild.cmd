setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="devtools" --name="Install swift-llbuild" --flag=SW_SKIP_DEVTOOLS_LLBUILD
if errorlevel 1 exit /b 0

cmake --build %SW_LLBUILD_BUILD_DIR% --target install

endlocal
