cmake^
 -G Ninja^
 -S %SW_XML2_SOURCES_DIR%^
 -B %SW_XML2_BUILD_DIR%^
 -C %SW_WORKSPACE%\cmake\caches\windows-x86_64.cmake^
 -C %SW_WORKSPACE%\cmake\caches\libxml2.cmake^
 -D CMAKE_BUILD_TYPE=MinSizeRel^
 -D CMAKE_INSTALL_PREFIX=%SW_XML2_INSTALL_DIR%^
 -D BUILD_SHARED_LIBS=NO^
 -D BUILD_TESTING=NO
 