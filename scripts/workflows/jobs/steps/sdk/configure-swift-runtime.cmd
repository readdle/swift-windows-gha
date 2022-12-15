setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="sdk" --name="Configure Runtime" --flag=SW_SKIP_SDK_RUNTIME
if errorlevel 1 exit /b 0

if [%SW_SWIFT_SDK_SPEC%]==[readdle] (
    set SW_LLVM_PDB=-D LLVM_ENABLE_PDB=ON
)

if "%SW_SWIFT_BRANCH_SPEC%"=="5.3" if defined GITHUB_ACTIONS (
  set SW_PYTHON_OPTIONS=-D PYTHON_EXECUTABLE="%SW_PYTHON_DIR%\python.exe"
)

cmake^
 -G Ninja^
 -S %SW_SWIFT_SOURCES_DIR%^
 -B %SW_RUNTIME_BUILD_DIR%^
 -C %SW_WORKSPACE%\cmake\caches\windows-x86_64-clang.cmake^
 -C %SW_WORKSPACE%\cmake\caches\swift-runtime-windows-x86_64.cmake^
 -D CMAKE_BUILD_TYPE=Release^
 -D LLVM_DIR=%SW_BUILD_DIR%\llvm\lib\cmake\llvm^
 -D SWIFT_NATIVE_SWIFT_TOOLS_PATH=%SW_TOOLCHAIN_DIR%\usr\bin^
 -D SWIFT_PATH_TO_LIBDISPATCH_SOURCE=%SW_DISPATCH_SOURCES_DIR%^
 -D CMAKE_INSTALL_PREFIX=%SW_SDK_INSTALL_DIR%^
 -D SWIFT_WINDOWS_x86_64_ICU_UC_INCLUDE=%SW_ICU_DIR%\usr\include\unicode^
 -D SWIFT_WINDOWS_x86_64_ICU_UC=%SW_ICU_DIR%\usr\lib\icuuc%SW_ICU_VERSION%.lib^
 -D SWIFT_WINDOWS_x86_64_ICU_I18N_INCLUDE=%SW_ICU_DIR%\usr\include^
 -D SWIFT_WINDOWS_x86_64_ICU_I18N=%SW_ICU_DIR%\usr\lib\icuin%SW_ICU_VERSION%.lib^
 %SW_PYTHON_OPTIONS%^
 %SW_LLVM_PDB%

if errorlevel 1 goto :eof

if "%SW_SWIFT_BRANCH_SPEC%"=="5.3" (
  mklink "%SW_RUNTIME_BUILD_DIR%\bin\swiftc" "%SW_TOOLCHAIN_DIR%\usr\bin\swiftc.exe"
  exit /b 0
)

endlocal
