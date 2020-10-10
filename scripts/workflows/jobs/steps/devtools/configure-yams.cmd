setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="devtools" --name="Configure Yams" --flag=SW_SKIP_DEVTOOLS_YAMS
if errorlevel 1 exit /b 0

cmake^
 -G Ninja^
 -S %SW_YAMS_SOURCES_DIR%^
 -B %SW_YAMS_BUILD_DIR%^
 -C %SW_WORKSPACE%\cmake\caches\windows-x86_64.cmake^
 -D CMAKE_Swift_SDK=%SW_SDK_DIR%^
 -C %SW_WORKSPACE%\cmake\caches\windows-x86_64-swift-flags.cmake^
 -D CMAKE_BUILD_TYPE=Release^
 -D CMAKE_INSTALL_PREFIX=%SW_TOOLCHAIN_INSTALL_DIR%^
 -D BUILD_TESTING=NO^
 -D CMAKE_C_COMPILER=cl

endlocal
