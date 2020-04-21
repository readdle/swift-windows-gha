setlocal

set SW_STEPS_DIR=%SW_WORKSPACE%\scripts\workflows\jobs\steps\zlib

call %SW_STEPS_DIR%\configure-build-environment.cmd^
 && call %SW_STEPS_DIR%\checkout-zlib.cmd^
 && call %SW_STEPS_DIR%\configure-zlib.cmd^
 && call %SW_STEPS_DIR%\build-zlib.cmd^
 && call %SW_STEPS_DIR%\install-zlib.cmd

endlocal
