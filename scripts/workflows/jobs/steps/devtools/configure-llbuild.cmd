setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="devtools" --name="Configure swift-llbuild" --flag=SW_SKIP_DEVTOOLS_LLBUILD
if errorlevel 1 exit /b 0

cmake^
 -G Ninja^
 -S %SW_LLBUILD_SOURCES_DIR%^
 -B %SW_LLBUILD_BUILD_DIR%^
 -C %SW_WORKSPACE%\cmake\caches\windows-x86_64.cmake^
 -D CMAKE_Swift_SDK=%SW_SDK_DIR%^
 -C %SW_WORKSPACE%\cmake\caches\windows-x86_64-swift-flags.cmake^
 -D CMAKE_BUILD_TYPE=Release^
 -D CMAKE_INSTALL_PREFIX=%SW_TOOLCHAIN_INSTALL_DIR%^
 -D LLBUILD_SUPPORT_BINDINGS=Swift^
 -D SQLite3_LIBRARY=%SW_SQLITE_DIR%\usr\lib\SQLite3.lib^
 -D SQLite3_INCLUDE_DIR=%SW_SQLITE_DIR%\usr\include

endlocal
