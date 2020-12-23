setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="sdk" --name="Configure XCTest" --flag=SW_SKIP_SDK_XCTEST
if errorlevel 1 exit /b 0

cmake^
 -G Ninja^
 -S %SW_XCTEST_SOURCES_DIR%^
 -B %SW_XCTEST_BUILD_DIR%^
 -C %SW_WORKSPACE%\cmake\caches\windows-x86_64-clang.cmake^
 -D SWIFT_STDLIB_DIR=%SW_STDLIB_BUILD_DIR%^
 -C %SW_WORKSPACE%\cmake\caches\windows-x86_64-swift-flags.cmake^
 -D CMAKE_BUILD_TYPE=Release^
 -D CMAKE_INSTALL_PREFIX=%SW_XCTEST_INSTALL_DIR%^
 -D ENABLE_TESTING=NO^
 -D dispatch_DIR=%SW_DISPATCH_BUILD_DIR%\cmake\modules^
 -D Foundation_DIR=%SW_FOUNDATION_BUILD_DIR%\cmake\modules

endlocal
