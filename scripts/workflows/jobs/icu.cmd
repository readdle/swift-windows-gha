setlocal

%SW_PRE_JOB% --name="ICU" --flag=SW_SKIP_ICU
if errorlevel 1 exit /b 0

set SW_STEPS_DIR=%SW_WORKSPACE%\scripts\workflows\jobs\steps\icu

call %SW_STEPS_DIR%\configure-build-environment.cmd^
 && call %SW_STEPS_DIR%\checkout-icu.cmd^
 && call %SW_STEPS_DIR%\patch-icu.cmd^
 && call %SW_STEPS_DIR%\configure-icu.cmd^
 && call %SW_STEPS_DIR%\build-icu.cmd^
 && call %SW_STEPS_DIR%\install-icu.cmd^
 && call %SW_STEPS_DIR%\clean-icu.cmd
 
set SW_ERROR=%ERRORLEVEL%
subst /d %SW_ICU_DRIVE%

endlocal & exit /b %SW_ERROR%
