copy cmake\ICU\CMakeLists-%SW_ICU_VERSION%.txt %SW_ICU_SOURCES_DIR%\icu4c\CMakeLists.txt
if errorlevel 1 goto :eof

cmake^
 -G Ninja^
 -S T:\icu4c^
 -B %SW_ICU_BUILD_DIR%^
 -C %SW_WORKSPACE%\cmake\caches\windows-x86_64.cmake^
 -D CMAKE_BUILD_TYPE=MinSizeRel^
 -D CMAKE_INSTALL_PREFIX=%SW_ICU_INSTALL_DIR%^
 -D BUILD_SHARED_LIBS=YES^
 -D BUILD_TOOLS=YES
