setlocal enabledelayedexpansion

if not "%SW_SWIFT_BRANCH_SPEC%"=="main" if not "%SW_SWIFT_BRANCH_SPEC%"=="5.4" (
   echo Skipping swift-serialize-diagnostics
   goto :eof
)

cmake --build %SW_LLVM_TOOLS_BUILD_DIR% --target swift-serialize-diagnostics swift-def-to-yaml-converter

endlocal