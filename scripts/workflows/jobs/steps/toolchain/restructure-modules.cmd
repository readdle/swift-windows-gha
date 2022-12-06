setlocal enabledelayedexpansion

if not "%SW_SWIFT_BRANCH_SPEC%"=="5.5" if not "%SW_SWIFT_BRANCH_SPEC%"=="main" (
  %SW_LOG_JOB_INFO% --message="Skip module restructure"
  exit /b 0
)

for %%M in (_InternalSwiftScan, _InternalSwiftSyntaxParser) do (
  %SW_LOG_JOB_INFO% --message="Restructuring %%M module"
  move /y "%SW_TOOLCHAIN_INSTALL_DIR%\lib\swift\%%M" "%SW_TOOLCHAIN_INSTALL_DIR%\include"
  move "%SW_TOOLCHAIN_INSTALL_DIR%\lib\swift\windows\%%M.lib" "%SW_TOOLCHAIN_INSTALL_DIR%\lib"
)

exit /b 0

endlocal
