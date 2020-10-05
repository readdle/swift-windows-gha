setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="sdk" --name="Install libdispatch" --flag=SW_SKIP_SDK_DISPATCH
if errorlevel 1 exit /b 0

cmake --build %SW_DISPATCH_BUILD_DIR% --target install

endlocal
