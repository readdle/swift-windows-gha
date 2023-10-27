setlocal

%SW_LOG_JOB_INFO% --message="Installing build tools..."

set SW_TOOLS_INSTALL_DIR=%SW_INSTALL_DIR%\build-tools\bin

mkdir %SW_TOOLS_INSTALL_DIR%^
 && copy %SW_TOOLS_BUILD_DIR%\bin\llvm-config.exe %SW_TOOLS_INSTALL_DIR%^
 && copy %SW_TOOLS_BUILD_DIR%\bin\llvm-tblgen.exe %SW_TOOLS_INSTALL_DIR%^
 && copy %SW_TOOLS_BUILD_DIR%\bin\clang-tblgen.exe %SW_TOOLS_INSTALL_DIR%^
 && copy %SW_TOOLS_BUILD_DIR%\bin\clang-pseudo-gen.exe %SW_TOOLS_INSTALL_DIR%^
 && copy %SW_TOOLS_BUILD_DIR%\bin\clang-tidy-confusable-chars-gen.exe %SW_TOOLS_INSTALL_DIR%^
 && copy %SW_TOOLS_BUILD_DIR%\bin\lldb-tblgen.exe %SW_TOOLS_INSTALL_DIR%^
 && copy %SW_TOOLS_BUILD_DIR%\bin\swift-serialize-diagnostics.exe %SW_TOOLS_INSTALL_DIR%^
 && copy %SW_TOOLS_BUILD_DIR%\bin\swift-def-to-strings-converter.exe %SW_TOOLS_INSTALL_DIR%^
 && copy %SW_TOOLS_BUILD_DIR%\bin\swift-compatibility-symbols.exe %SW_TOOLS_INSTALL_DIR%

endlocal
