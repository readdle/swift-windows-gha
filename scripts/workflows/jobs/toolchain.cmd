setlocal enabledelayedexpansion

set SW_LOG_TOOLCHAIN_INFO=%SW_LOG_INFO% --scope toolchain
set SW_LOG_TOOLCHAIN_WARNING=%SW_LOG_WARNING% --scope toolchain

if "%SW_SKIP_TOOLCHAIN%"=="YES" (
  %SW_LOG_TOOLCHAIN_WARNING% --message="Skipping job"
  goto :eof
)
%SW_LOG_TOOLCHAIN_INFO% --message="Starting job"

set SW_STEPS_DIR=%SW_WORKSPACE%\scripts\workflows\jobs\steps\toolchain

call %SW_STEPS_DIR%\configure-build-environment.cmd^
 && call %SW_STEPS_DIR%\checkout-llvm.cmd^
 && call %SW_STEPS_DIR%\checkout-cmark.cmd^
 && call %SW_STEPS_DIR%\checkout-libdispatch.cmd^
 && call %SW_STEPS_DIR%\checkout-swift.cmd^
 && call %SW_STEPS_DIR%\patch-llvm.cmd^
 && call %SW_STEPS_DIR%\patch-swift.cmd^
 && call %SW_STEPS_DIR%\configure-llvm-build-tools.cmd^
 && call %SW_STEPS_DIR%\build-llvm-build-tools.cmd^
 && call %SW_STEPS_DIR%\build-clang-build-tools.cmd^
 && call %SW_STEPS_DIR%\build-lldb-build-tools.cmd^
 && call %SW_STEPS_DIR%\configure-sdk-modules.cmd^
 && call %SW_STEPS_DIR%\configure-toolchain.cmd^
 && call %SW_STEPS_DIR%\build-toolchain.cmd^
 && call %SW_STEPS_DIR%\install-toolchain.cmd^
 && call %SW_STEPS_DIR%\configure-test-environment.cmd^
 && call %SW_STEPS_DIR%\check-swift.cmd

endlocal
