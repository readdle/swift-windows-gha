cmake --build %SW_DISPATCH_BUILD_DIR% --target ExperimentalTest

if %SW_IGNORE_TEST_FAILURES% neq 0 exit /b 0
