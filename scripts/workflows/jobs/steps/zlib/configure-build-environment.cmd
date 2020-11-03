%SW_SET_ENV% SW_LOG_ZLIB_INFO "%SW_LOG_INFO% --scope zlib"
%SW_SET_ENV% SW_LOG_ZLIB_WARNING "%SW_LOG_WARNING% --scope zlib"

%SW_LOG_ZLIB_INFO% --message="Configuring build environment"

%SW_SET_ENV% SW_ZLIB_REF refs/tags/v%SW_ZLIB_VERSION%
%SW_SET_ENV% SW_ZLIB_SOURCES_DIR %SW_SOURCES_DIR%\zlib
%SW_SET_ENV% SW_ZLIB_BUILD_DIR %SW_BUILD_DIR%\zlib
%SW_SET_ENV% SW_ZLIB_INSTALL_DIR %SW_INSTALL_DIR%\Library\zlib-%SW_ZLIB_VERSION%\usr

%SW_LOG_ZLIB_INFO% --prefix="Git ref:           " --message="%SW_ZLIB_REF%"
%SW_LOG_ZLIB_INFO% --prefix="Sources directory: " --message="%SW_ZLIB_SOURCES_DIR%"
%SW_LOG_ZLIB_INFO% --prefix="Build directory:   " --message="%SW_ZLIB_BUILD_DIR%"
%SW_LOG_ZLIB_INFO% --prefix="Install directory: " --message="%SW_ZLIB_INSTALL_DIR%"
