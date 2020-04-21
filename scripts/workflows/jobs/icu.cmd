setlocal

set SW_STEPS_DIR=%SW_WORKSPACE%\scripts\workflows\jobs\steps\icu

call %SW_STEPS_DIR%\configure-build-environment.cmd^
 && call %SW_STEPS_DIR%\checkout-icu.cmd^
 && call %SW_STEPS_DIR%\configure-icu.cmd^
 && call %SW_STEPS_DIR%\build-icu.cmd^
 && call %SW_STEPS_DIR%\install-icu.cmd

call %SW_STEPS_DIR%\finalize.cmd

endlocal
