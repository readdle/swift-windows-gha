cmake --build %SW_FOUNDATION_BUILD_DIR% --target test

if %SW_IGNORE_TEST_FAILURES% neq 0 exit /b 0
