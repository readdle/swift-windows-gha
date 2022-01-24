setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="sdk" --name="Install libdispatch" --flag=SW_SKIP_SDK_DISPATCH
if errorlevel 1 exit /b 0

if not "%SW_SWIFT_BRANCH_SPEC%"=="5.5" if not "%SW_SWIFT_BRANCH_SPEC%"=="main" goto do-install

:: Clean previous installation
if exist "%SW_SDK_INSTALL_DIR%\lib\swift\windows\x86_64\Dispatch.swiftmodule" rmdir /q /s "%SW_SDK_INSTALL_DIR%\lib\swift\windows\x86_64\Dispatch.swiftmodule"

:do-install
cmake --build %SW_DISPATCH_BUILD_DIR% --target install

endlocal
