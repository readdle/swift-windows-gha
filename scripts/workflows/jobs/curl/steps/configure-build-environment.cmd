call .github\workflows\vsenv.cmd -arch=x64 -host_arch=x64
          
set SW_ARTIFACTS_PATH=%GITHUB_WORKSPACE%\a
set SW_INSTALL_PATH=%GITHUB_WORKSPACE%\i\Library\libcurl-%SW_CURL_VERSION%\usr
set SW_ZLIB_PATH=%SW_ARTIFACTS_PATH%\Library\zlib-%SW_ZLIB_VERSION%

echo ::set-env name=SW_ARTIFACTS_PATH::%SW_ARTIFACTS_PATH%
echo ::set-env name=SW_INSTALL_PATH::%SW_INSTALL_PATH%
echo ::set-env name=SW_ZLIB_PATH::%SW_ZLIB_PATH%
