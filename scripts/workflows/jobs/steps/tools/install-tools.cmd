%SW_LOG_JOB_INFO% --message="Installing build tools..."

mkdir %SW_INSTALL_DIR%\build-tools\bin^
 && copy %SW_TOOLS_BUILD_DIR%\bin\llvm-config.exe %SW_INSTALL_DIR%\build-tools\bin^
 && copy %SW_TOOLS_BUILD_DIR%\bin\llvm-tblgen.exe %SW_INSTALL_DIR%\build-tools\bin^
 && copy %SW_TOOLS_BUILD_DIR%\bin\clang-tblgen.exe %SW_INSTALL_DIR%\build-tools\bin^
 && copy %SW_TOOLS_BUILD_DIR%\bin\lldb-tblgen.exe %SW_INSTALL_DIR%\build-tools\bin^
 && copy %SW_TOOLS_BUILD_DIR%\bin\swift-serialize-diagnostics.exe %SW_INSTALL_DIR%\build-tools\bin^
 && copy %SW_TOOLS_BUILD_DIR%\bin\swift-def-to-strings-converter.exe %SW_INSTALL_DIR%\build-tools\bin
