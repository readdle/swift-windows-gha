setlocal enabledelayedexpansion

set SW_LOG_ZLIB_INFO=%SW_LOG_INFO% --scope zlib
set SW_LOG_ZLIB_WARNING=%SW_LOG_WARNING% --scope zlib

if "%SW_SKIP_ZLIB%"=="YES" (
  %SW_LOG_ZLIB_WARNING% --message="******************** Skipping job ********************"
  goto :eof
)
%SW_LOG_ZLIB_INFO% --message="******************** Starting job ********************"

set SW_STEPS_DIR=%SW_WORKSPACE%\scripts\workflows\jobs\steps\zlib

call %SW_STEPS_DIR%\configure-build-environment.cmd^
 && call %SW_STEPS_DIR%\checkout-zlib.cmd^
 && call %SW_STEPS_DIR%\configure-zlib.cmd^
 && call %SW_STEPS_DIR%\build-zlib.cmd^
 && call %SW_STEPS_DIR%\install-zlib.cmd

endlocal
