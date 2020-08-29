setlocal enabledelayedexpansion

set SW_LOG_XML2_INFO=%SW_LOG_INFO% --scope libxml2
set SW_LOG_XML2_WARNING=%SW_LOG_WARNING% --scope libxml2

if "%SW_SKIP_XML2%"=="YES" (
  %SW_LOG_XML2_WARNING% --message="Skipping job"
  goto :eof
)
%SW_LOG_XML2_INFO% --message="Starting job"

set SW_STEPS_DIR=%SW_WORKSPACE%\scripts\workflows\jobs\steps\libxml2

call %SW_STEPS_DIR%\configure-build-environment.cmd^
 && call %SW_STEPS_DIR%\checkout-libxml2.cmd^
 && call %SW_STEPS_DIR%\configure-libxml2.cmd^
 && call %SW_STEPS_DIR%\build-libxml2.cmd^
 && call %SW_STEPS_DIR%\install-libxml2.cmd

endlocal
