setlocal

set SW_LOG_ICU_INFO=%SW_LOG_INFO% --scope icu
set SW_STEPS_DIR=%SW_WORKSPACE%\scripts\workflows\jobs\steps\icu

call %SW_STEPS_DIR%\configure-build-environment.cmd^
 && call %SW_STEPS_DIR%\checkout-icu.cmd^
 && call %SW_STEPS_DIR%\patch-icu.cmd^
 && call %SW_STEPS_DIR%\configure-icu.cmd^
 && call %SW_STEPS_DIR%\build-icu.cmd^
 && call %SW_STEPS_DIR%\install-icu.cmd

set SW_ERROR=%ERRORLEVEL%
subst T: /d

endlocal & exit /b %SW_ERROR%
