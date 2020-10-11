setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="devtools" --name="Configure indexstore-db" --flag=SW_SKIP_DEVTOOLS_INDEXSTORE_DB
if errorlevel 1 exit /b 0

cmake^
 -G Ninja^
 -S %SW_INDEXSTORE_DB_SOURCES_DIR%^
 -B %SW_INDEXSTORE_DB_BUILD_DIR%^
 -D CMAKE_CXX_FLAGS="-I %SW_SDK_DIR%\usr\lib\swift -I %SW_SDK_DIR%\usr\lib\swift\Block"^
 -C %SW_WORKSPACE%\cmake\caches\windows-x86_64-clang.cmake^
 -D CMAKE_Swift_SDK=%SW_SDK_DIR%^
 -C %SW_WORKSPACE%\cmake\caches\windows-x86_64-swift-flags.cmake^
 -D CMAKE_BUILD_TYPE=Release^
 -D CMAKE_INSTALL_PREFIX=%SW_TOOLCHAIN_INSTALL_DIR%^
 -D BUILD_SHARED_LIBS=YES

endlocal
