setlocal enabledelayedexpansion

if not "%SW_SWIFT_BRANCH_SPEC%"=="5.5" if not "%SW_SWIFT_BRANCH_SPEC%"=="main" (
  %SW_LOG_SDK_INFO% --message="Skip module restructure"
  exit /b 0
)

for %%M in (Swift, SwiftOnoneSupport, CRT, WinSDK, _Concurrency, _Differentiation, _Distributed) do (
  %SW_LOG_SDK_INFO% --message="Restructuring %%M module"
  move /y "%SW_SDK_INSTALL_DIR%\lib\swift\windows\%%M.swiftmodule" "%SW_SDK_INSTALL_DIR%\lib\swift\windows\x86_64"
)

for %%M in (Block, dispatch, os) do (
  %SW_LOG_SDK_INFO% --message="Restructuring %%M headers"
  move /y "%SW_SDK_INSTALL_DIR%\lib\swift\%%M" "%SW_SDK_INSTALL_DIR%\include"
)

for %%M in (BlocksRuntime, dispatch, swiftDispatch) do (
  %SW_LOG_SDK_INFO% --message="Restructuring import library for %%M"
  move /y "%SW_SDK_INSTALL_DIR%\lib\swift\windows\%%M.lib" "%SW_SDK_INSTALL_DIR%\lib\swift\windows\x86_64"
)

%SW_LOG_SDK_INFO% --message="Restructuring Dispatch"
move /y "%SW_SDK_INSTALL_DIR%\lib\swift\windows\x86_64\Dispatch.swiftmodule" "%SW_SDK_INSTALL_DIR%\lib\swift\windows\x86_64\_.swiftmodule"
md "%SW_SDK_INSTALL_DIR%\lib\swift\windows\x86_64\Dispatch.swiftmodule"
move /y "%SW_SDK_INSTALL_DIR%\lib\swift\windows\x86_64\_.swiftmodule" "%SW_SDK_INSTALL_DIR%\lib\swift\windows\x86_64\Dispatch.swiftmodule\x86_64-unknown-windows-msvc.swiftmodule"
move /y "%SW_SDK_INSTALL_DIR%\lib\swift\windows\x86_64\Dispatch.swiftdoc" "%SW_SDK_INSTALL_DIR%\lib\swift\windows\x86_64\Dispatch.swiftmodule\x86_64-unknown-windows-msvc.swiftdoc"

for %%M in (CoreFoundation, CFXMLInterface, CFURLSessionInterface) do (
  %SW_LOG_SDK_INFO% --message="Removing %%M headers"
  rd /s /q "%SW_SDK_INSTALL_DIR%\lib\swift\%%M"
)

for %%M in (Foundation, FoundationNetworking, FoundationXML) do (
  %SW_LOG_SDK_INFO% --message="Restructuring %%M"
  move /y "%SW_SDK_INSTALL_DIR%\lib\swift\windows\%%M.lib" "%SW_SDK_INSTALL_DIR%\lib\swift\windows\x86_64"
  move /y "%SW_SDK_INSTALL_DIR%\lib\swift\windows\x86_64\%%M.swiftmodule" "%SW_SDK_INSTALL_DIR%\lib\swift\windows\x86_64\_.swiftmodule"
  md "%SW_SDK_INSTALL_DIR%\lib\swift\windows\x86_64\%%M.swiftmodule"
  move /y "%SW_SDK_INSTALL_DIR%\lib\swift\windows\x86_64\_.swiftmodule" "%SW_SDK_INSTALL_DIR%\lib\swift\windows\x86_64\%%M.swiftmodule\x86_64-unknown-windows-msvc.swiftmodule"
  move /y "%SW_SDK_INSTALL_DIR%\lib\swift\windows\x86_64\%%M.swiftdoc" "%SW_SDK_INSTALL_DIR%\lib\swift\windows\x86_64\%%M.swiftmodule\x86_64-unknown-windows-msvc.swiftdoc"
)

exit /b 0

endlocal
