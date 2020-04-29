cmake^
 -G Ninja^
 -S %SW_SOURCES_DIR%\toolchain\llvm^
 -B %SW_BUILD_DIR%\llvm-tools^
 -C %GITHUB_WORKSPACE%\cmake\caches\windows-x86_64.cmake^
 -D CMAKE_BUILD_TYPE=Release^
 -D LLVM_ENABLE_ASSERTIONS=NO^
 -D LLVM_ENABLE_PROJECTS="clang;lldb"^
 -D LLDB_DISABLE_PYTHON=YES^
 -D LLDB_INCLUDE_TESTS=NO
