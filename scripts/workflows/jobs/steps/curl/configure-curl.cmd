cmake^
 -G Ninja^
 -S %SW_CURL_SOURCES_DIR%^
 -B %SW_CURL_BUILD_DIR%^
 -C %SW_WORKSPACE%\cmake\caches\windows-x86_64.cmake^
 -C %SW_WORKSPACE%\cmake\caches\curl.cmake^
 -D CMAKE_BUILD_TYPE=MinSizeRel^
 -D CMAKE_INSTALL_PREFIX=%SW_CURL_INSTALL_DIR%^
 -D ZLIB_ROOT=%SW_ZLIB_DIR%\usr^
 -D BUILD_SHARED_LIBS=NO^
 -D BUILD_TESTING=NO
 