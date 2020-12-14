setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="toolchain" --name="Configure Test Environment" --flag=SW_SKIP_TOOLCHAIN_SWIFT_TEST
if errorlevel 1 exit /b 0

endlocal

%SW_SET_ENV% PATH "%SW_ICU_PATH%\usr\bin;%SW_TOOLCHAIN_INSTALL_DIR%\bin;%PATH%;%ProgramFiles%\Git\usr\bin"
