cmake --build %SW_DISPATCH_BUILD_DIR% --target ExperimentalTest

if defined GITHUB_ACTION goto :eof
exit /b 0
