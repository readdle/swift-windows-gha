subst T: "%SW_WORKSPACE%\icu\icu4c"
if errorlevel 1 goto :eof

cmake^
 -G Ninja^
 -S T:\^
 -B %SW_WORKSPACE%\b^
 -C %SW_WORKSPACE%\cmake\caches\windows-x86_64.cmake^
 -D CMAKE_BUILD_TYPE=MinSizeRel^
 -D CMAKE_INSTALL_PREFIX=%SW_INSTALL_PATH%^
 -D BUILD_SHARED_LIBS=YES^
 -D BUILD_TOOLS=YES
