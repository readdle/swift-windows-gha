setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="toolchain" --name="Test Swift" --flag=SW_SKIP_TOOLCHAIN_SWIFT_TEST
if errorlevel 1 exit /b 0

cmake --build %SW_TOOLCHAIN_BUILD_DIR% --target check-swift

if errorlevel 1 (
  %SW_LOG_WARNING% --scope="toolchain" --message="Swift check failed"
)
exit /b 0

endlocal
