cmake --build %SW_ICU_BUILD_DIR% --target install

if "%SW_SWIFT_SDK_SPEC%"=="readdle" (
    %SW_LOG_JOB_INFO% --message="Manually copying %SW_ICU_BUILD_DIR%\icudt%SW_ICU_RELEASE%.lib"
    copy %SW_ICU_BUILD_DIR%\icudt%SW_ICU_RELEASE%.lib %SW_ICU_INSTALL_DIR%\lib\icudt%SW_ICU_RELEASE%.lib
)
