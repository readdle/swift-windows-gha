if [%SW_SWIFT_TEST_ENABLED%]==[NO] (
    echo Skipping Swift tests configuration
    goto :eof
)

call scripts\tools\set-env.cmd PATH "%SW_ICU_PATH%\usr\bin;%SW_TOOLCHAIN_INSTALL_DIR%\bin;%PATH%;%ProgramFiles%\Git\usr\bin"
