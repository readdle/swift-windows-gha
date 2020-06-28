if [%SW_FOUNDATION_TEST_ENABLED%]==[NO] (
    echo Skipping Foundation tests environment configuration
    goto :eof
)

call scripts\tools\set-env.cmd PATH "%SW_ICU_PATH%\usr\bin;%SW_STDLIB_BUILD_DIR%\bin;%SW_DISPATCH_BUILD_DIR%;%SW_FOUNDATION_BUILD_DIR%\Foundation;%SW_XCTEST_BUILD_DIR%;%PATH%;%ProgramFiles%\Git\usr\bin"
