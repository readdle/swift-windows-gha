%SW_LOG_SQLITE_INFO% --prefix="Starting step:" --message="Configure Build Environment"

set SW_SQLITE_URL=https://sqlite.org/2020/sqlite-amalgamation-%SW_SQLITE_RELEASE%.zip
set "SW_SQLITE_SOURCES_DIR=%SW_SOURCES_DIR%\sqlite-amalgamation-%SW_SQLITE_RELEASE%"
set "SW_SQLITE_BUILD_DIR=%SW_BUILD_DIR%\sqlite"
set "SW_SQLITE_INSTALL_DIR=%SW_INSTALL_DIR%\Library\sqlite-%SW_SQLITE_VERSION%\usr"

%SW_LOG_SQLITE_INFO% --prefix="Sources URL:       " --message="%SW_SQLITE_URL%"
%SW_LOG_SQLITE_INFO% --prefix="Sources directory: " --message="%SW_SQLITE_SOURCES_DIR%"
%SW_LOG_SQLITE_INFO% --prefix="Build directory:   " --message="%SW_SQLITE_BUILD_DIR%"
%SW_LOG_SQLITE_INFO% --prefix="Install directory: " --message="%SW_SQLITE_INSTALL_DIR%"
