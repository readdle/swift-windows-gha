setlocal enabledelayedexpansion

set SW_LOG_SDK_INFO=%SW_LOG_INFO% --scope sdk
set SW_LOG_SDK_WARNING=%SW_LOG_WARNING% --scope sdk

%SW_PRE_JOB% --name="SDK" --flag=SW_SKIP_SDK
if errorlevel 1 exit /b 0

set SW_STEPS_DIR=%SW_WORKSPACE%\scripts\workflows\jobs\steps\sdk

call %SW_STEPS_DIR%\configure-build-environment.cmd^
 && call %SW_STEPS_DIR%\checkout-foundation.cmd^
 && call %SW_STEPS_DIR%\checkout-xctest.cmd^
 && call %SW_STEPS_DIR%\patch-stdlib.cmd^
 && call %SW_STEPS_DIR%\configure-llvm.cmd^
 && call %SW_STEPS_DIR%\configure-swift-stdlib.cmd^
 && call %SW_STEPS_DIR%\build-swift-stdlib.cmd^
 && call %SW_STEPS_DIR%\configure-libdispatch.cmd^
 && call %SW_STEPS_DIR%\build-libdispatch.cmd^
 && call %SW_STEPS_DIR%\configure-foundation.cmd^
 && call %SW_STEPS_DIR%\build-foundation.cmd^
 && call %SW_STEPS_DIR%\configure-xctest.cmd^
 && call %SW_STEPS_DIR%\build-xctest.cmd^
 && call %SW_STEPS_DIR%\install-swift-stdlib.cmd^
 && call %SW_STEPS_DIR%\install-foundation.cmd^
 && call %SW_STEPS_DIR%\install-xctest.cmd^
 && call %SW_STEPS_DIR%\install-libdispatch.cmd^
 && call %SW_STEPS_DIR%\generate-plists.cmd^
 && call %SW_STEPS_DIR%\configure-libdispatch-tests.cmd^
 && call %SW_STEPS_DIR%\build-libdispatch-tests.cmd^
 && call %SW_STEPS_DIR%\test-libdispatch.cmd^
 && call %SW_STEPS_DIR%\configure-foundation-test-environment.cmd^
 && call %SW_STEPS_DIR%\configure-foundation-tests.cmd^
 && call %SW_STEPS_DIR%\build-foundation-tests.cmd^
 && call %SW_STEPS_DIR%\test-foundation-ctest.cmd^
 && call %SW_STEPS_DIR%\test-foundation-xctest.cmd

endlocal
