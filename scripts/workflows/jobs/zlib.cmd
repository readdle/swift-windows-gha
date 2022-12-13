setlocal enabledelayedexpansion

set SW_LOG_JOB_INFO=%SW_LOG_INFO% --scope zlib
set SW_LOG_JOB_WARNING=%SW_LOG_WARNING% --scope zlib

%SW_PRE_JOB% --name="zlib" --flag=SW_SKIP_ZLIB
if errorlevel 1 exit /b 0

set SW_STEPS_DIR=%SW_WORKSPACE%\scripts\workflows\jobs\steps\zlib

call %SW_STEPS_DIR%\configure-build-environment.cmd^
 && call %SW_STEPS_DIR%\checkout-zlib.cmd^
 && call %SW_STEPS_DIR%\configure-zlib.cmd^
 && call %SW_STEPS_DIR%\build-zlib.cmd^
 && call %SW_STEPS_DIR%\install-zlib.cmd

endlocal
