subst T: "%GITHUB_WORKSPACE%\icu\icu4c"
cmake^
 -G Ninja^
 -S T:\^
 -B %GITHUB_WORKSPACE%\b^
 -C %GITHUB_WORKSPACE%\cmake\caches\windows-x86_64.cmake^
 -D CMAKE_BUILD_TYPE=MinSizeRel^
 -D CMAKE_INSTALL_PREFIX=%SW_INSTALL_PATH%^
 -D BUILD_SHARED_LIBS=YES^
 -D BUILD_TOOLS=YES
