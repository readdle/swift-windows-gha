setlocal

%SW_PRE_JOB% --name="ICU Tools" --flag=SW_SKIP_ICU
if errorlevel 1 exit /b 0

set SW_STEPS_DIR=%SW_WORKSPACE%\scripts\workflows\jobs\steps\icu-tools

call %SW_STEPS_DIR%\configure-build-environment.cmd^
 && call %SW_STEPS_DIR%\checkout-swift-installer-scripts.cmd^
 && call %SW_STEPS_DIR%\checkout-icu.cmd^
 && call %SW_STEPS_DIR%\configure-icu-tools.cmd^
 && call %SW_STEPS_DIR%\build-icu-tools.cmd^
 && call %SW_STEPS_DIR%\install-icu-tools.cmd^
 && call %SW_STEPS_DIR%\clean-icu-tools.cmd

endlocal
