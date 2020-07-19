if [%SW_DISPATCH_TEST_ENABLED%]==[NO] (
    echo Skipping Dispatch tests build
    goto :eof
)

cmake --build %SW_DISPATCH_BUILD_DIR%
