%SW_LOG_JOB_INFO% --message="Copying "%SW_SWIFT_INSTALLER_SCRIPTS_SOURCES_DIR%\shared\ICU\CMakeLists.txt" to "%SW_ICU_SOURCES_DIR%\icu4c\CMakeLists.txt""
copy "%SW_SWIFT_INSTALLER_SCRIPTS_SOURCES_DIR%\shared\ICU\CMakeLists.txt" "%SW_ICU_SOURCES_DIR%\icu4c\CMakeLists.txt"
if errorlevel 1 goto :eof

%SW_LOG_JOB_INFO% --message="Configuring ICU"

cmake^
 -B %SW_ICU_BUILD_DIR%^
 -D BUILD_SHARED_LIBS=NO^
 -D BUILD_TOOLS=NO^
 -D CMAKE_BUILD_TYPE=Release^
 -D CMAKE_C_COMPILER=cl^
 -D CMAKE_C_FLAGS="/GS- /Oy /Gw /Gy"^
 -D CMAKE_CXX_COMPILER=cl^
 -D CMAKE_CXX_FLAGS="/GS- /Oy /Gw /Gy"^
 -D CMAKE_MT=mt^
 -D CMAKE_INSTALL_PREFIX=%SW_ICU_INSTALL_DIR%^
 -D ICU_TOOLS_DIR=%SW_ICU_TOOLS_DIR%^
 -G Ninja^
 -S %SW_ICU_SOURCES_DIR%/icu4c
