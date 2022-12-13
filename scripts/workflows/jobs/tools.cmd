setlocal enabledelayedexpansion

%SW_PRE_JOB% --name="Tools" --flag=SW_SKIP_TOOLCHAIN
if errorlevel 1 exit /b 0

set SW_STEPS_DIR=%SW_WORKSPACE%\scripts\workflows\jobs\steps\tools

call %SW_STEPS_DIR%\configure-build-environment.cmd^
 && call %SW_STEPS_DIR%\checkout-llvm.cmd^
 && call %SW_STEPS_DIR%\checkout-cmark.cmd^
 && call %SW_STEPS_DIR%\checkout-libdispatch.cmd^
 && call %SW_STEPS_DIR%\checkout-swift.cmd^
 && call %SW_STEPS_DIR%\checkout-swift-syntax.cmd^
 && call %SW_STEPS_DIR%\configure-tools.cmd^
 && call %SW_STEPS_DIR%\build-llvm-config.cmd^
 && call %SW_STEPS_DIR%\build-llvm-tblgen.cmd^
 && call %SW_STEPS_DIR%\build-clang-tblgen.cmd^
 && call %SW_STEPS_DIR%\build-lldb-tblgen.cmd^
 && call %SW_STEPS_DIR%\build-swift-serialize-diagnostics.cmd^
 && call %SW_STEPS_DIR%\build-swift-def-to-strings-converter.cmd^
 && call %SW_STEPS_DIR%\build-swift-compatibility-symbols.cmd^
 && call %SW_STEPS_DIR%\install-tools.cmd

endlocal^
 && set SW_DISPATCH_REPO=%SW_DISPATCH_REPO%^
 && set SW_LLVM_REF=%SW_LLVM_REF%^
 && set SW_SWIFT_REF=%SW_SWIFT_REF%^
 && set SW_CMARK_REF=%SW_CMARK_REF%^
 && set SW_SWIFT_SYNTAX_REF=%SW_SWIFT_SYNTAX_REF%^
 && set SW_DISPATCH_REF=%SW_DISPATCH_REF%
