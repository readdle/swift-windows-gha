setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="sdk" --name="Install StdLib" --flag=SW_SKIP_SDK_STDLIB
if errorlevel 1 exit /b 0

cmake --build %SW_STDLIB_BUILD_DIR% --target install

endlocal
