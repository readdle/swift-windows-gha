%SW_LOG_JOB_INFO% --message="Cleaning..."
rmdir /q /s %SW_ICU_SOURCES_DIR%
rmdir /q /s %SW_ICU_TOOLS_BUILD_DIR%
exit /b 0
