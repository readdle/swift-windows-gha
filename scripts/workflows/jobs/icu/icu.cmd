setlocal

set SW_STEPS_DIR=%SW_WORKSPACE%\scripts\workflows\jobs\icu\steps

call %SW_STEPS_DIR%\fetch-icu.cmd

endlocal
