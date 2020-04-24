cmake^
 -G Ninja^
 -S %SW_WORKSPACE%\libxml2^
 -B %SW_WORKSPACE%\b^
 -C %SW_WORKSPACE%\cmake\caches\windows-x86_64.cmake^
 -C %SW_WORKSPACE%\cmake\caches\libxml2.cmake^
 -D CMAKE_BUILD_TYPE=MinSizeRel^
 -D CMAKE_INSTALL_PREFIX=%SW_INSTALL_PATH%^
 -D BUILD_SHARED_LIBS=NO^
 -D BUILD_TESTING=NO
 