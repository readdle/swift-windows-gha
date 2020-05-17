cmake --build %SW_TOOLCHAIN_BUILD_DIR% --target check-swift

if %SW_IGNORE_TEST_FAILURES% neq 0 exit /b 0
