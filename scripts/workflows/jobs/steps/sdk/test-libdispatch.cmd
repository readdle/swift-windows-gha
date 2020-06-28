if [%SW_DISPATCH_TEST_ENABLED%]==[NO] (
    echo Skipping Dispatch tests
    goto :eof
)


cmake --build %SW_DISPATCH_BUILD_DIR% --target ExperimentalTest

if %SW_IGNORE_TEST_FAILURES% neq 0 exit /b 0
