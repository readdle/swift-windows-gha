cmake^
 -G Ninja^
 -S %SW_SOURCES_PATH%\llvm-project\llvm^
 -B %SW_BINARIES_PATH%\llvm^
 -C %GITHUB_WORKSPACE%\cmake\caches\windows-x86_64.cmake^
 -D CMAKE_BUILD_TYPE=Release^
 -D LLVM_HOST_TRIPLE=x86_64-unknown-windows-msvc
