cmake^
 -G Ninja^
 -S %SW_SOURCES_DIR%\llvm-project\llvm^
 -B %SW_BUILD_DIR%\llvm^
 -C %GITHUB_WORKSPACE%\cmake\caches\windows-x86_64.cmake^
 -D CMAKE_BUILD_TYPE=Release^
 -D LLVM_HOST_TRIPLE=x86_64-unknown-windows-msvc
