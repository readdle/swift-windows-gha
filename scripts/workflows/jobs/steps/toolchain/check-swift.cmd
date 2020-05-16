cmake --build %SW_TOOLCHAIN_BUILD_DIR% --target check-swift

if defined GITHUB_ACTION goto :eof
exit /b 0
