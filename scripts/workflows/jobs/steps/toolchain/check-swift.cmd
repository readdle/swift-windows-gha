setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="toolchain" --name="Test Swift" --flag=SW_SKIP_TOOLCHAIN_SWIFT_TEST
if errorlevel 1 exit /b 0

cmake --build %SW_TOOLCHAIN_BUILD_DIR% --target check-swift

if %SW_IGNORE_TEST_FAILURES% neq 0 exit /b 0

endlocal
