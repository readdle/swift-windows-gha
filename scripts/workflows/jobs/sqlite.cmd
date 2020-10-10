setlocal enabledelayedexpansion

set SW_STEPS_DIR=%SW_WORKSPACE%\scripts\workflows\jobs\steps\sqlite

call %SW_STEPS_DIR%\configure-job-environment.cmd

%SW_PRE_JOB% --name="SQLite" --flag=SW_SKIP_SQLITE
if errorlevel 1 exit /b 0

call %SW_STEPS_DIR%\configure-build-environment.cmd^
 && call %SW_STEPS_DIR%\download-sqlite.cmd^
 && call %SW_STEPS_DIR%\configure-sqlite.cmd^
 && call %SW_STEPS_DIR%\build-sqlite.cmd^
 && call %SW_STEPS_DIR%\install-sqlite.cmd

endlocal
