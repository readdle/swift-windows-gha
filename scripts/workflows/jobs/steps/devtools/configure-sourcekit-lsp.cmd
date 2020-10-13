setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="devtools" --name="Configure sourcekit-lsp" --flag=SW_SKIP_DEVTOOLS_SOURCEKIT
if errorlevel 1 exit /b 0

cmake^
 -G Ninja^
 -S %SW_SOURCEKIT_SOURCES_DIR%^
 -B %SW_SOURCEKIT_BUILD_DIR%^
 -C %SW_WORKSPACE%\cmake\caches\windows-x86_64-clang.cmake^
 -D CMAKE_Swift_SDK=%SW_SDK_DIR%^
 -C %SW_WORKSPACE%\cmake\caches\windows-x86_64-swift-flags.cmake^
 -D CMAKE_BUILD_TYPE=Release^
 -D CMAKE_INSTALL_PREFIX=%SW_TOOLCHAIN_INSTALL_DIR%^
 -D LLBuild_DIR=%SW_LLBUILD_BUILD_DIR%\cmake\modules^
 -D TSC_DIR=%SW_TSC_BUILD_DIR%\cmake\modules^
 -D SwiftPM_DIR=%SW_SPM_BUILD_DIR%\cmake\modules^
 -D ArgumentParser_DIR=%SW_SAP_BUILD_DIR%\cmake\modules^
 -D IndexStoreDB_DIR=%SW_INDEXSTORE_DB_BUILD_DIR%\cmake\modules^
 -D BUILD_SHARED_LIBS=YES^
 -D BUILD_TESTING=NO

endlocal