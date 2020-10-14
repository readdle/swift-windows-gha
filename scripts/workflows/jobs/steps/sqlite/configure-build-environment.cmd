%SW_LOG_SQLITE_INFO% --prefix="Starting step:" --message="Configure Build Environment"

%SW_SET_ENV% SW_SQLITE_RELEASE 3300100
%SW_SET_ENV% SW_SQLITE_VERSION 3.30.1

%SW_SET_ENV% SW_SQLITE_URL https://sqlite.org/2019/sqlite-amalgamation-%SW_SQLITE_RELEASE%.zip
%SW_SET_ENV% SW_SQLITE_SOURCES_DIR %SW_SOURCES_DIR%\sqlite-amalgamation-%SW_SQLITE_RELEASE%
%SW_SET_ENV% SW_SQLITE_BUILD_DIR %SW_BUILD_DIR%\sqlite
%SW_SET_ENV% SW_SQLITE_INSTALL_DIR %SW_INSTALL_DIR%\Library\sqlite-%SW_SQLITE_VERSION%\usr

%SW_LOG_SQLITE_INFO% --prefix="Sources URL:       " --message="%SW_SQLITE_URL%"
%SW_LOG_SQLITE_INFO% --prefix="Sources directory: " --message="%SW_SQLITE_SOURCES_DIR%"
%SW_LOG_SQLITE_INFO% --prefix="Build directory:   " --message="%SW_SQLITE_BUILD_DIR%"
%SW_LOG_SQLITE_INFO% --prefix="Install directory: " --message="%SW_SQLITE_INSTALL_DIR%"
