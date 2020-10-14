%SW_LOG_SQLITE_INFO% --prefix="Starting step:" --message="Configure SQLite"

copy cmake\SQLite\CMakeLists.txt %SW_SQLITE_SOURCES_DIR%
if errorlevel 1 goto :eof

cmake^
 -G Ninja^
 -S %SW_SQLITE_SOURCES_DIR%^
 -B %SW_SQLITE_BUILD_DIR%^
 -C %SW_WORKSPACE%\cmake\caches\windows-x86_64.cmake^
 -D CMAKE_BUILD_TYPE=MinSizeRel^
 -D CMAKE_INSTALL_PREFIX=%SW_SQLITE_INSTALL_DIR%^
 -D BUILD_SHARED_LIBS=NO
