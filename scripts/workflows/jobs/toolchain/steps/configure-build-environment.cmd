call .github\workflows\vsenv.cmd -arch=x64 -host_arch=x64
          
set SW_ARTIFACTS_PATH=%GITHUB_WORKSPACE%\a
set SW_SOURCES_PATH=%GITHUB_WORKSPACE%\s
set SW_BINARIES_PATH=%GITHUB_WORKSPACE%\b
set SW_INSTALL_PATH=%GITHUB_WORKSPACE%\i\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain
set SW_ICU_PATH=%SW_ARTIFACTS_PATH%\Library\icu-%SW_ICU_VERSION%

echo ::set-env name=SW_ARTIFACTS_PATH::%SW_ARTIFACTS_PATH%
echo ::set-env name=SW_SOURCES_PATH::%SW_SOURCES_PATH%
echo ::set-env name=SW_BINARIES_PATH::%SW_BINARIES_PATH%
echo ::set-env name=SW_INSTALL_PATH::%SW_INSTALL_PATH%
echo ::set-env name=SW_ICU_PATH::%SW_ICU_PATH%
