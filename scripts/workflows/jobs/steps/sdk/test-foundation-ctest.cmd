if [%SW_FOUNDATION_TEST_ENABLED%]==[NO] (
    echo Skipping Foundation tests
    goto :eof
)

cmake --build %SW_FOUNDATION_BUILD_DIR% --target test

if %SW_IGNORE_TEST_FAILURES% neq 0 exit /b 0
