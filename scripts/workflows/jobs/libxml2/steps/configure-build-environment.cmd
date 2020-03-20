call .github\workflows\vsenv.cmd -arch=x64 -host_arch=x64
          
set SW_INSTALL_PATH=%GITHUB_WORKSPACE%\i\Library\libxml2-%SW_XML2_VERSION%\usr
echo ::set-env name=SW_INSTALL_PATH::%SW_INSTALL_PATH%
