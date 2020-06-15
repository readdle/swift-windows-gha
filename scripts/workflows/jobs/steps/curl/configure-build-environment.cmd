call scripts\tools\vs-env.cmd -arch=x64 -host_arch=x64

call scripts\tools\set-env.cmd SW_CURL_REF master
call scripts\tools\set-env.cmd SW_CURL_SOURCES_DIR %SW_SOURCES_DIR%\curl
call scripts\tools\set-env.cmd SW_CURL_BUILD_DIR %SW_BUILD_DIR%\curl
call scripts\tools\set-env.cmd SW_CURL_INSTALL_DIR %SW_INSTALL_DIR%\Library\libcurl-%SW_CURL_VERSION%\usr
call scripts\tools\set-env.cmd SW_ZLIB_DIR %SW_ARTIFACTS_DIR%\Library\zlib-%SW_ZLIB_VERSION%
