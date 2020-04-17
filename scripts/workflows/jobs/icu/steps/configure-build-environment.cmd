call .github\workflows\vsenv.cmd -arch=x64 -host_arch=x64

set SW_INSTALL_PATH=%GITHUB_WORKSPACE%\i\Library\icu-%SW_ICU_VERSION%\usr
echo ::set-env name=SW_INSTALL_PATH::%SW_INSTALL_PATH%

copy cmake\ICU\CMakeLists.txt icu\icu4c
