%SW_LOG_JOB_INFO% --message="Cleaning..."
rmdir /q /s %SW_CMARK_SOURCES_DIR%
rmdir /q /s %SW_LLVM_TOOLS_BUILD_DIR%
rmdir /q /s %SW_TOOLCHAIN_BUILD_DIR%

exit /b 0
