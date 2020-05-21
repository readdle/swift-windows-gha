cmake^
 -G Ninja^
 -S %SW_LLVM_SOURCES_DIR%^
 -B %SW_LLVM_BUILD_DIR%^
 -C %SW_WORKSPACE%\cmake\caches\windows-x86_64.cmake^
 -D CMAKE_BUILD_TYPE=Release^
 -D LLVM_HOST_TRIPLE=x86_64-unknown-windows-msvc
