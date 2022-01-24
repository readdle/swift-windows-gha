setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="sdk" --name="Install Foundation" --flag=SW_SKIP_SDK_FOUNDATION
if errorlevel 1 exit /b 0

if not "%SW_SWIFT_BRANCH_SPEC%"=="5.5" if not "%SW_SWIFT_BRANCH_SPEC%"=="main" goto do-install

:: Clean previous installation
for %%M in (Foundation, FoundationNetworking, FoundationXML) do (
  if exist "%SW_SDK_INSTALL_DIR%\lib\swift\windows\x86_64\%%M.swiftmodule" rmdir /q /s "%SW_SDK_INSTALL_DIR%\lib\swift\windows\x86_64\%%M.swiftmodule"
)

:do-install
cmake --build %SW_FOUNDATION_BUILD_DIR% --target install

endlocal
