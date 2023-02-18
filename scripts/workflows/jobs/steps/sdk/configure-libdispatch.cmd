setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="sdk" --name="Configure libdispatch" --flag=SW_SKIP_SDK_DISPATCH
if errorlevel 1 exit /b 0

if "%SW_SWIFT_SDK_SPEC%"=="readdle" (
    set SW_DISPATCH_PDB=-D DISPATCH_ENABLE_PDB=ON
)

FOR /F "tokens=* USEBACKQ" %%i IN (`cygpath -m "%SW_TOOLCHAIN_DIR%"`) DO (
  SET SW_TOOLCHAIN_DIR=%%i
)

cmake^
 -B %SW_DISPATCH_BUILD_DIR%^
 -D BUILD_SHARED_LIBS=YES^
 -D CMAKE_BUILD_TYPE=Release^
 -D CMAKE_C_COMPILER=%SW_TOOLCHAIN_DIR%/usr/bin/clang-cl.exe^
 -D CMAKE_C_COMPILER_TARGET=%SW_PLATFORM%-unknown-windows-msvc^
 -D CMAKE_C_FLAGS="/GS- /Oy /Gw /Gy"^
 -D CMAKE_CXX_COMPILER=%SW_TOOLCHAIN_DIR%/usr/bin/clang-cl.exe^
 -D CMAKE_CXX_COMPILER_TARGET=%SW_PLATFORM%-unknown-windows-msvc^
 -D CMAKE_CXX_FLAGS="/GS- /Oy /Gw /Gy"^
 -D CMAKE_MT=mt^
 -D CMAKE_INSTALL_PREFIX=%SW_SDK_INSTALL_DIR%^
 -D CMAKE_SYSTEM_NAME=Windows^
 -D CMAKE_SYSTEM_PROCESSOR=%SW_PLATFORM%^
 -D CMAKE_Swift_COMPILER=%SW_TOOLCHAIN_DIR%/usr/bin/swiftc.exe^
 -D CMAKE_Swift_COMPILER_TARGET=%SW_PLATFORM%-unknown-windows-msvc^
 -D CMAKE_Swift_FLAGS="-resource-dir %SW_SDK_INSTALL_DIR%/lib/swift -L%SW_SDK_INSTALL_DIR%/lib/swift/windows"^
 -G Ninja^
 -S %SW_DISPATCH_SOURCES_DIR%^
 -D BUILD_TESTING=NO^
 -D ENABLE_SWIFT=YES^
 %SW_DISPATCH_PDB%

endlocal