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
 && call %SW_STEPS_DIR%\checkout-tsc.cmd^
 && call %SW_STEPS_DIR%\checkout-yams.cmd^
 && call %SW_STEPS_DIR%\checkout-swift-argument-parser.cmd^
 && call %SW_STEPS_DIR%\configure-llbuild.cmd^
 && call %SW_STEPS_DIR%\build-llbuild.cmd^
 && call %SW_STEPS_DIR%\install-llbuild.cmd^
 && call %SW_STEPS_DIR%\configure-tsc.cmd^
 && call %SW_STEPS_DIR%\build-tsc.cmd^
 && call %SW_STEPS_DIR%\install-tsc.cmd^
 && call %SW_STEPS_DIR%\configure-yams.cmd^
 && call %SW_STEPS_DIR%\build-yams.cmd^
 && call %SW_STEPS_DIR%\install-yams.cmd^
 && call %SW_STEPS_DIR%\configure-swift-argument-parser.cmd^
 && call %SW_STEPS_DIR%\build-swift-argument-parser.cmd^
 && call %SW_STEPS_DIR%\install-swift-argument-parser.cmd

endlocal
