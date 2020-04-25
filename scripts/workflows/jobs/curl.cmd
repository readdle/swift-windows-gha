setlocal

set SW_STEPS_DIR=%SW_WORKSPACE%\scripts\workflows\jobs\steps\curl

call %SW_STEPS_DIR%\configure-build-environment.cmd^
 && call %SW_STEPS_DIR%\checkout-curl.cmd^
 && call %SW_STEPS_DIR%\configure-curl.cmd^
 && call %SW_STEPS_DIR%\build-curl.cmd^
 && call %SW_STEPS_DIR%\install-curl.cmd

endlocal
