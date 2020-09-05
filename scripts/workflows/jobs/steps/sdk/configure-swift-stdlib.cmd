setlocal enabledelayedexpansion

if "%SW_SWIFT_SDK_SPEC%"=="readdle" (
    set SW_LLVM_PDB=-D LLVM_ENABLE_PDB=ON
)

if "%SW_SWIFT_BRANCH_SPEC%"=="5.3" if defined GITHUB_ACTIONS (
    set SW_PYTHON_OPTIONS=-D PYTHON_EXECUTABLE=%pythonLocation%\python.exe
)

cmake^
 -G Ninja^
 -S %SW_SWIFT_SOURCES_DIR%^
 -B %SW_STDLIB_BUILD_DIR%^
 -C %SW_WORKSPACE%\cmake\caches\windows-x86_64-clang.cmake^
 -C %SW_WORKSPACE%\cmake\caches\swift-stdlib-windows-x86_64.cmake^
 -D CMAKE_BUILD_TYPE=Release^
 -D LLVM_DIR=%SW_BUILD_DIR%\llvm\lib\cmake\llvm^
 -D SWIFT_NATIVE_SWIFT_TOOLS_PATH=%SW_TOOLCHAIN_PATH%\usr\bin^
 -D CMAKE_INSTALL_PREFIX=%SW_SDK_INSTALL_DIR%^
 -D SWIFT_WINDOWS_x86_64_ICU_UC_INCLUDE=%SW_ICU_PATH%\usr\include\unicode^
 -D SWIFT_WINDOWS_x86_64_ICU_UC=%SW_ICU_PATH%\usr\lib\icuuc%SW_ICU_VERSION%.lib^
 -D SWIFT_WINDOWS_x86_64_ICU_I18N_INCLUDE=%SW_ICU_PATH%\usr\include^
 -D SWIFT_WINDOWS_x86_64_ICU_I18N=%SW_ICU_PATH%\usr\lib\icuin%SW_ICU_VERSION%.lib^
 %SW_PYTHON_OPTIONS%^
 %SW_LLVM_PDB%

endlocal
