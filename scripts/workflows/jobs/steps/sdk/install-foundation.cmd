setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="sdk" --name="Install Foundation" --flag=SW_SKIP_SDK_FOUNDATION
if errorlevel 1 exit /b 0

cmake --build %SW_FOUNDATION_BUILD_DIR% --target install

endlocal
