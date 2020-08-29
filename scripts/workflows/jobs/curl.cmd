setlocal

set SW_LOG_CURL_INFO=%SW_LOG_INFO% --scope curl
set SW_LOG_CURL_WARNING=%SW_LOG_WARNING% --scope curl

if "%SW_SKIP_CURL%"=="YES" (
  %SW_LOG_CURL_WARNING% --message="Skipping job"
  goto :eof
)
%SW_LOG_CURL_INFO% --message="Starting job"

set SW_STEPS_DIR=%SW_WORKSPACE%\scripts\workflows\jobs\steps\curl

call %SW_STEPS_DIR%\configure-build-environment.cmd^
 && call %SW_STEPS_DIR%\checkout-curl.cmd^
 && call %SW_STEPS_DIR%\configure-curl.cmd^
 && call %SW_STEPS_DIR%\build-curl.cmd^
 && call %SW_STEPS_DIR%\install-curl.cmd

endlocal
