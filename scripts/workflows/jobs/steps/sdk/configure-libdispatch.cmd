setlocal enabledelayedexpansion

if [%SW_SWIFT_SDK_SPEC%]==[readdle] (
    set SW_DISPATCH_PDB=-D DISPATCH_ENABLE_PDB=ON
)

cmake^
 -G Ninja^
 -S %SW_DISPATCH_SOURCES_DIR%^
 -B %SW_DISPATCH_BUILD_DIR%^
 -C %SW_WORKSPACE%\cmake\caches\windows-x86_64-clang.cmake^
 -D SWIFT_STDLIB_DIR=%SW_STDLIB_BUILD_DIR%^
 -C %SW_WORKSPACE%\cmake\caches\windows-x86_64-swift-flags.cmake^
 -D CMAKE_BUILD_TYPE=Release^
 -D CMAKE_INSTALL_PREFIX=%SW_SDK_INSTALL_DIR%^
 -D BUILD_TESTING=NO^
 -D ENABLE_SWIFT=YES^
 %SW_DISPATCH_PDB%

endlocal