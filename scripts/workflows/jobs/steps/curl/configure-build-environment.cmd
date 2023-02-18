set "SW_LOG_JOB_INFO=%SW_LOG_INFO% --scope curl"

%SW_LOG_JOB_INFO% --message="Configuring build environment..."

set SW_CURL_REF=master
set "SW_CURL_SOURCES_DIR=%SW_SOURCES_DIR%\curl"
set "SW_CURL_BUILD_DIR=%SW_BUILD_DIR%\curl"
set "SW_CURL_INSTALL_DIR=%SW_INSTALL_DIR%\Library\libcurl-%SW_CURL_VERSION%\usr"
set "SW_ZLIB_DIR=%SW_ARTIFACTS_DIR%\Library\zlib-%SW_ZLIB_VERSION%"

%SW_LOG_JOB_INFO% --prefix="Git ref:           " --message="%SW_CURL_REF%"
%SW_LOG_JOB_INFO% --prefix="Sources directory: " --message="%SW_CURL_SOURCES_DIR%"
%SW_LOG_JOB_INFO% --prefix="Build directory:   " --message="%SW_CURL_BUILD_DIR%"
%SW_LOG_JOB_INFO% --prefix="Install directory: " --message="%SW_CURL_INSTALL_DIR%"
%SW_LOG_JOB_INFO% --prefix="zlib directory:    " --message="%SW_ZLIB_DIR%"
