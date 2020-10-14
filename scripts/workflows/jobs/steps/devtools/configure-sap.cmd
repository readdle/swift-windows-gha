setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="devtools" --name="Configure swift-argument-parser" --flag=SW_SKIP_DEVTOOLS_SAP
if errorlevel 1 exit /b 0

cmake^
 -G Ninja^
 -S %SW_SAP_SOURCES_DIR%^
 -B %SW_SAP_BUILD_DIR%^
 -D CMAKE_Swift_SDK=%SW_SDK_DIR%^
 -C %SW_WORKSPACE%\cmake\caches\windows-x86_64-swift-flags.cmake^
 -D CMAKE_BUILD_TYPE=Release^
 -D CMAKE_INSTALL_PREFIX=%SW_TOOLCHAIN_INSTALL_DIR%^
 -D BUILD_SHARED_LIBS=YES^
 -D BUILD_TESTING=NO

endlocal
