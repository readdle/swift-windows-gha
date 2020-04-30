if [%SW_SWIFT_BRANCH_SPEC%]==[5.2] (
  set SW_LLVM_REF=swift/swift-5.2-branch
  set SW_CMARK_REF=swift-5.2-branch
  set SW_LIBDISPATCH_REF=swift-5.2-branch
  set SW_SWIFT_REF=swift-5.2-branch

  set SW_LLDB_OPTIONS=-DLLDB_DISABLE_PYTHON=YES
) else (
  set SW_LLVM_REF=swift/master
  set SW_CMARK_REF=master
  set SW_LIBDISPATCH_REF=master
  set SW_SWIFT_REF=master
)

set SW_TOOLCHAIN_INSTALL_DIR=%SW_INSTALL_DIR%\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain
set SW_ICU_PATH=%SW_ARTIFACTS_DIR%\Library\icu-%SW_ICU_VERSION%

call scripts\tools\vsenv.cmd -arch=x64 -host_arch=x64

echo ::set-env name=SW_LLVM_REF::%SW_LLVM_REF%
echo ::set-env name=SW_CMARK_REF::%SW_CMARK_REF%
echo ::set-env name=SW_LIBDISPATCH_REF::%SW_LIBDISPATCH_REF%
echo ::set-env name=SW_SWIFT_REF::%SW_SWIFT_REF%
echo ::set-env name=SW_TOOLCHAIN_INSTALL_DIR::%SW_TOOLCHAIN_INSTALL_DIR%
echo ::set-env name=SW_ICU_PATH::%SW_ICU_PATH%

echo ::set-env name=SW_LLDB_OPTIONS::%SW_LLDB_OPTIONS%
