setlocal enabledelayedexpansion

%SW_PRE_JOB% --name="libxml2" --flag=SW_SKIP_XML2
if errorlevel 1 exit /b 0

set SW_STEPS_DIR=%SW_WORKSPACE%\scripts\workflows\jobs\steps\libxml2

call %SW_STEPS_DIR%\configure-build-environment.cmd^
 && call %SW_STEPS_DIR%\checkout-libxml2.cmd^
 && call %SW_STEPS_DIR%\configure-libxml2.cmd^
 && call %SW_STEPS_DIR%\build-libxml2.cmd^
 && call %SW_STEPS_DIR%\install-libxml2.cmd

endlocal
