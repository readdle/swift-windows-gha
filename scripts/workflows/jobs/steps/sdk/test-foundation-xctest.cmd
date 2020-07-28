if [%SW_FOUNDATION_TEST_ENABLED%]==[NO] (
    echo Skipping Foundation tests
    goto :eof
)

%SW_FOUNDATION_BUILD_DIR%\TestFoundation.app\TestFoundation.exe

if %SW_IGNORE_TEST_FAILURES% neq 0 exit /b 0
