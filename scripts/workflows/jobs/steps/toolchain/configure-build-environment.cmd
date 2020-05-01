if [%SW_SWIFT_BRANCH_SPEC%]==[5.2] (
  set SW_LLVM_REF=swift/swift-5.2-branch
  set SW_CMARK_REF=swift-5.2-branch
  set SW_DISPATCH_REF=swift-5.2-branch
  set SW_SWIFT_REF=swift-5.2-branch

  set SW_LLDB_OPTIONS=-DLLDB_DISABLE_PYTHON=YES
) else (
  set SW_LLVM_REF=swift/master
  set SW_CMARK_REF=master
  set SW_DISPATCH_REF=master
  set SW_SWIFT_REF=master
)

set SW_LLVM_SOURCES_DIR=%SW_SOURCES_DIR%\toolchain
set SW_CMARK_SOURCES_DIR=%SW_LLVM_SOURCES_DIR%\cmark
set SW_SWIFT_SOURCES_DIR=%SW_LLVM_SOURCES_DIR%\swift
set SW_LLVM_TOOLS_SOURCES_DIR=%SW_LLVM_SOURCES_DIR%\llvm
set SW_DISPATCH_SOURCES_DIR=%SW_SOURCES_DIR%\swift-corelibs-libdispatch

set SW_LLVM_TOOLS_BUILD_DIR=%SW_BUILD_DIR%\llvm-tools

set SW_TOOLCHAIN_INSTALL_DIR=%SW_INSTALL_DIR%\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr
set SW_ICU_PATH=%SW_ARTIFACTS_DIR%\Library\icu-%SW_ICU_VERSION%

set SW_LLVM_TABLEGEN=%SW_LLVM_TOOLS_BUILD_DIR%\bin\llvm-tblgen.exe
set SW_CLANG_TABLEGEN=%SW_LLVM_TOOLS_BUILD_DIR%\bin\clang-tblgen.exe
set SW_LLDB_TABLEGEN=%SW_LLVM_TOOLS_BUILD_DIR%\bin\lldb-tblgen.exe

call scripts\tools\vsenv.cmd -arch=x64 -host_arch=x64

if not defined GITHUB_ACTION goto :eof

echo ::set-env name=SW_LLVM_REF::%SW_LLVM_REF%
echo ::set-env name=SW_CMARK_REF::%SW_CMARK_REF%
echo ::set-env name=SW_DISPATCH_REF::%SW_DISPATCH_REF%
echo ::set-env name=SW_SWIFT_REF::%SW_SWIFT_REF%

echo ::set-env name=SW_LLVM_SOURCES_DIR::%SW_LLVM_SOURCES_DIR%
echo ::set-env name=SW_CMARK_SOURCES_DIR::%SW_CMARK_SOURCES_DIR%
echo ::set-env name=SW_SWIFT_SOURCES_DIR::%SW_SWIFT_SOURCES_DIR%
echo ::set-env name=SW_LLVM_TOOLS_SOURCES_DIR::%SW_LLVM_TOOLS_SOURCES_DIR%
echo ::set-env name=SW_DISPATCH_SOURCES_DIR::%SW_DISPATCH_SOURCES_DIR%

echo ::set-env name=SW_LLVM_TOOLS_BUILD_DIR::%SW_LLVM_TOOLS_BUILD_DIR%

echo ::set-env name=SW_TOOLCHAIN_INSTALL_DIR::%SW_TOOLCHAIN_INSTALL_DIR%
echo ::set-env name=SW_ICU_PATH::%SW_ICU_PATH%

echo ::set-env name=SW_LLVM_TABLEGEN::%SW_LLVM_TABLEGEN%
echo ::set-env name=SW_CLANG_TABLEGEN::%SW_CLANG_TABLEGEN%
echo ::set-env name=SW_LLDB_TABLEGEN::%SW_LLDB_TABLEGEN%

echo ::set-env name=SW_LLDB_OPTIONS::%SW_LLDB_OPTIONS%
