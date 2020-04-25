set SW_CURL_REF=master
set SW_CURL_SOURCES_DIR=%SW_SOURCES_DIR%\curl
set SW_CURL_BUILD_DIR=%SW_BUILD_DIR%\curl
set SW_CURL_INSTALL_DIR=%SW_INSTALL_DIR%\Library\libcurl-%SW_CURL_VERSION%\usr
set SW_ZLIB_DIR=%SW_ARTIFACTS_DIR%\Library\zlib-%SW_ZLIB_VERSION%

call scripts\tools\vsenv.cmd -arch=x64 -host_arch=x64

if not defined GITHUB_ACTION goto :eof

echo ::set-env name=SW_CURL_REF::%SW_CURL_REF%          
echo ::set-env name=SW_CURL_SOURCES_DIR::%SW_CURL_SOURCES_DIR%
echo ::set-env name=SW_CURL_BUILD_DIR::%SW_CURL_BUILD_DIR%
echo ::set-env name=SW_CURL_INSTALL_DIR::%SW_CURL_INSTALL_DIR%
echo ::set-env name=SW_ZLIB_DIR::%SW_ZLIB_DIR%
