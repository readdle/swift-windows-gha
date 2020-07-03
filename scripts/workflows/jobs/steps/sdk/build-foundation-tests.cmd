if [%SW_FOUNDATION_TEST_ENABLED%]==[NO] (
    echo Skipping Foundation tests build
    goto :eof
)

cmake --build %SW_FOUNDATION_BUILD_DIR%
