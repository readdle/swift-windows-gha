setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="devtools" --name="Configure swift-package-manager" --flag=SW_SKIP_DEVTOOLS_SPM
if errorlevel 1 exit /b 0

cmake^
 -G Ninja^
 -S %SW_SPM_SOURCES_DIR%^
 -B %SW_SPM_BUILD_DIR%^
 -C %SW_WORKSPACE%\cmake\caches\windows-x86_64-clang.cmake^
 -D CMAKE_Swift_SDK=%SW_SDK_DIR%^
 -C %SW_WORKSPACE%\cmake\caches\windows-x86_64-swift-flags.cmake^
 -D CMAKE_BUILD_TYPE=Release^
 -D CMAKE_INSTALL_PREFIX=%SW_TOOLCHAIN_INSTALL_DIR%^
 -D LLBuild_DIR=%SW_LLBUILD_BUILD_DIR%\cmake\modules^
 -D TSC_DIR=%SW_TSC_BUILD_DIR%\cmake\modules^
 -D Yams_DIR=%SW_YAMS_BUILD_DIR%\cmake\modules^
 -D SwiftDriver_DIR=%SW_SWIFT_DRIVER_BUILD_DIR%\cmake\modules^
 -D ArgumentParser_DIR=%SW_SAP_BUILD_DIR%\cmake\modules^
 -D BUILD_SHARED_LIBS=YES^
 -D BUILD_TESTING=NO

endlocal
