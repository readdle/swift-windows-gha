%SW_SET_ENV% SW_LOG_XML2_INFO "%SW_LOG_INFO% --scope libxml2"
%SW_SET_ENV% SW_LOG_XML2_WARNING "%SW_LOG_WARNING% --scope libxml2"

%SW_LOG_XML2_INFO% --message="Configuring build environment"

%SW_SET_ENV% SW_XML2_REF cmake
%SW_SET_ENV% SW_XML2_SOURCES_DIR %SW_SOURCES_DIR%\libxml2
%SW_SET_ENV% SW_XML2_BUILD_DIR %SW_BUILD_DIR%\libxml2
%SW_SET_ENV% SW_XML2_INSTALL_DIR %SW_INSTALL_DIR%\Library\libxml2-%SW_XML2_VERSION%\usr

%SW_LOG_XML2_INFO% --prefix="Git ref:           " --message="%SW_XML2_REF%"
%SW_LOG_XML2_INFO% --prefix="Sources directory: " --message="%SW_XML2_SOURCES_DIR%"
%SW_LOG_XML2_INFO% --prefix="Build directory:   " --message="%SW_XML2_BUILD_DIR%"
%SW_LOG_XML2_INFO% --prefix="Install directory: " --message="%SW_XML2_INSTALL_DIR%"
