cmake^
 -G Ninja^
 -S %GITHUB_WORKSPACE%\libxml2^
 -B %GITHUB_WORKSPACE%\b^
 -C %GITHUB_WORKSPACE%\cmake\caches\windows-x86_64.cmake^
 -C %GITHUB_WORKSPACE%\cmake\caches\libxml2.cmake^
 -D CMAKE_BUILD_TYPE=MinSizeRel^
 -D CMAKE_INSTALL_PREFIX=%SW_INSTALL_PATH%^
 -D BUILD_SHARED_LIBS=NO^
 -D BUILD_TESTING=NO
 