setlocal enabledelayedexpansion

%SW_PRE_JOB% --name="Toolchain" --flag=SW_SKIP_TOOLCHAIN
if errorlevel 1 exit /b 0

set SW_STEPS_DIR=%SW_WORKSPACE%\scripts\workflows\jobs\steps\toolchain

call %SW_STEPS_DIR%\configure-build-environment.cmd^
 && call %SW_STEPS_DIR%\checkout-swift-experimental-string-processing.cmd^
 && call %SW_STEPS_DIR%\patch-llvm.cmd^
 && call %SW_STEPS_DIR%\patch-swift.cmd^
 && call %SW_STEPS_DIR%\configure-toolchain.cmd^
 && call %SW_STEPS_DIR%\build-toolchain.cmd^
 && call %SW_STEPS_DIR%\install-toolchain.cmd
@REM  && call %SW_STEPS_DIR%\restructure-modules.cmd^

endlocal
