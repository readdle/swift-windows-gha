call scripts\tools\vsenv.cmd -arch=x64 -host_arch=x64
          
set SW_TOOLCHAIN_INSTALL_DIR=%SW_INSTALL_DIR%\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain
set SW_ICU_PATH=%SW_ARTIFACTS_DIR%\Library\icu-%SW_ICU_VERSION%

if [%SW_SWIFT_BRANCH_SPEC%]==[5.2] SET SW_LLDB_OPTIONS=-DLLDB_DISABLE_PYTHON=YES

echo ::set-env name=SW_TOOLCHAIN_INSTALL_DIR::%SW_TOOLCHAIN_INSTALL_DIR%
echo ::set-env name=SW_ICU_PATH::%SW_ICU_PATH%

echo ::set-env name=SW_LLDB_OPTIONS::%SW_LLDB_OPTIONS%
