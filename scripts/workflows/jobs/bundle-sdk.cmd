setlocal

%SW_PRE_JOB% --name="Bundle SDK" --flag=SW_SKIP_BUNDLE
if errorlevel 1 exit /b 0

set SW_STEPS_DIR=%SW_WORKSPACE%\scripts\workflows\jobs\steps\bundle-sdk

call %SW_STEPS_DIR%\configure-build-environment.cmd^
 && call %SW_STEPS_DIR%\copy-sdk-files.cmd

endlocal