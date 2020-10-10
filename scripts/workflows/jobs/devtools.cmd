setlocal enabledelayedexpansion

set SW_STEPS_DIR=%SW_WORKSPACE%\scripts\workflows\jobs\steps\devtools

call %SW_STEPS_DIR%\configure-job-environment.cmd

if not "%SW_SWIFT_BRANCH_SPEC%"=="master" (
   %SW_LOG_DEVTOOLS_WARNING% --message="Not compatible with specified Swift release (%SW_SWIFT_BRANCH_SPEC%), skipping build"
   exit /b 0
)

%SW_PRE_JOB% --name="DevTools" --flag=SW_SKIP_DEVTOOLS
if errorlevel 1 exit /b 0

call %SW_STEPS_DIR%\configure-build-environment.cmd^
 && call %SW_STEPS_DIR%\checkout-llbuild.cmd^
 && call %SW_STEPS_DIR%\configure-llbuild.cmd^
 && call %SW_STEPS_DIR%\build-llbuild.cmd^
 && call %SW_STEPS_DIR%\install-llbuild.cmd

endlocal
