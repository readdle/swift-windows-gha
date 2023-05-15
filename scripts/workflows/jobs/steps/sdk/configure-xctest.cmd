setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="sdk" --name="Configure XCTest" --flag=SW_SKIP_SDK_XCTEST
if errorlevel 1 exit /b 0

FOR /F "tokens=* USEBACKQ" %%i IN (`cygpath -m "%SW_TOOLCHAIN_DIR%"`) DO (
  SET SW_TOOLCHAIN_DIR=%%i
)

cmake^
 -B %SW_XCTEST_BUILD_DIR%^
 -D BUILD_SHARED_LIBS=YES^
 -D CMAKE_BUILD_TYPE=Release^
 -D CMAKE_MT=mt^
 -D CMAKE_INSTALL_PREFIX=%SW_XCTEST_INSTALL_DIR%^
 -D CMAKE_SYSTEM_NAME=Windows^
 -D CMAKE_SYSTEM_PROCESSOR=%SW_PLATFORM%^
 -D CMAKE_Swift_COMPILER=%SW_TOOLCHAIN_DIR%/usr/bin/swiftc.exe^
 -D CMAKE_Swift_COMPILER_TARGET=%SW_PLATFORM%-unknown-windows-msvc^
 -D CMAKE_Swift_FLAGS="-g -debug-info-format=codeview -Xlinker /INCREMENTAL:NO -Xlinker /DEBUG -Xlinker /OPT:REF -Xlinker /OPT:ICF -resource-dir %SW_SDK_INSTALL_DIR%/lib/swift -L%SW_SDK_INSTALL_DIR%/lib/swift/windows -vfsoverlay %SW_RUNTIME_BUILD_DIR%/stdlib/windows-vfs-overlay.yaml"^
 -D CMAKE_Swift_FLAGS_RELEASE="-O"^
 -G Ninja^
 -S %SW_XCTEST_SOURCES_DIR%^
 -D ENABLE_TESTING=NO^
 -D dispatch_DIR=%SW_DISPATCH_BUILD_DIR%/cmake/modules^
 -D Foundation_DIR=%SW_FOUNDATION_BUILD_DIR%/cmake/modules

endlocal
