cmake --build %SW_FOUNDATION_BUILD_DIR% --target test

if defined GITHUB_ACTION goto :eof
exit /b 0