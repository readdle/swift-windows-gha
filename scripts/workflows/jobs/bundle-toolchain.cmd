setlocal

%SW_PRE_JOB% --name="Bundle Toolchain" --flag=SW_SKIP_BUNDLE
if errorlevel 1 exit /b 0

set SW_STEPS_DIR=%SW_WORKSPACE%\scripts\workflows\jobs\steps\bundle-toolchain

call %SW_STEPS_DIR%\configure-build-environment.cmd^
 && call %SW_STEPS_DIR%\copy-toolchain-files.cmd

endlocal