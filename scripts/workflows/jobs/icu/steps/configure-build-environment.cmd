call scripts\tools\vsenv.cmd -arch=x64 -host_arch=x64

set SW_INSTALL_PATH=%SW_WORKSPACE%\i\Library\icu-%SW_ICU_VERSION%\usr

copy cmake\ICU\CMakeLists.txt icu\icu4c

if not defined GITHUB_ACTION goto :eof

echo ::set-env name=SW_INSTALL_PATH::%SW_INSTALL_PATH%
