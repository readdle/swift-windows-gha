if [%SW_SWIFT_BRANCH_SPEC%]==[5.2] (
  if not defined SW_LLVM_REF set SW_LLVM_REF=swift/swift-5.2-branch
  if not defined SW_DISPATCH_REF set SW_DISPATCH_REF=swift-5.2-branch
  if not defined SW_SWIFT_REF set SW_SWIFT_REF=swift-5.2-branch

  set SW_FOUNDATION_REF=swift-5.2-branch
  set SW_XCTEST_REF=swift-5.2-branch
) else if [%SW_SWIFT_BRANCH_SPEC%]==[5.3] (
  if not defined SW_LLVM_REF set SW_LLVM_REF=swift/release/5.3
  if not defined SW_DISPATCH_REF set SW_DISPATCH_REF=release/5.3
  if not defined SW_SWIFT_REF set SW_SWIFT_REF=release/5.3

  set SW_FOUNDATION_REF=release/5.3
  set SW_XCTEST_REF=release/5.3
) else (
  if not defined SW_LLVM_REF set SW_LLVM_REF=swift/master
  if not defined SW_DISPATCH_REF set SW_DISPATCH_REF=master
  if not defined SW_SWIFT_REF set SW_SWIFT_REF=master

  set SW_FOUNDATION_REF=master
  set SW_XCTEST_REF=master
)

set SW_LLVM_PROJECT_SOURCES_DIR=%SW_SOURCES_DIR%\llvm-project
set SW_LLVM_SOURCES_DIR=%SW_LLVM_PROJECT_SOURCES_DIR%\llvm
set SW_SWIFT_SOURCES_DIR=%SW_LLVM_PROJECT_SOURCES_DIR%\swift
set SW_DISPATCH_SOURCES_DIR=%SW_SOURCES_DIR%\swift-corelibs-libdispatch
set SW_FOUNDATION_SOURCES_DIR=%SW_SOURCES_DIR%\swift-corelibs-foundation
set SW_XCTEST_SOURCES_DIR=%SW_SOURCES_DIR%\swift-corelibs-xctest

set SW_LLVM_BUILD_DIR=%SW_BUILD_DIR%\llvm
set SW_STDLIB_BUILD_DIR=%SW_BUILD_DIR%\swift-stdlib
set SW_DISPATCH_BUILD_DIR=%SW_BUILD_DIR%\libdispatch
set SW_FOUNDATION_BUILD_DIR=%SW_BUILD_DIR%\foundation
set SW_XCTEST_BUILD_DIR=%SW_BUILD_DIR%\xctest

set SW_PLATFORM_PATH=%SW_INSTALL_DIR%\Library\Developer\Platforms\Windows.platform

set SW_SDK_PATH=%SW_PLATFORM_PATH%\Developer\SDKs\Windows.sdk
set SW_SDK_INSTALL_DIR=%SW_SDK_PATH%\usr
set SW_XCTEST_INSTALL_PATH=%SW_PLATFORM_PATH%\Developer\Library\XCTest-development\usr

set SW_TOOLCHAIN_PATH=%SW_ARTIFACTS_DIR%\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain
set SW_CURL_PATH=%SW_ARTIFACTS_DIR%\Library\libcurl-%SW_CURL_VERSION%
set SW_ICU_PATH=%SW_ARTIFACTS_DIR%\Library\icu-%SW_ICU_VERSION%
set SW_XML2_PATH=%SW_ARTIFACTS_DIR%\Library\libxml2-%SW_XML2_VERSION%
set SW_ZLIB_PATH=%SW_ARTIFACTS_DIR%\Library\zlib-%SW_ZLIB_VERSION%

set CTEST_OUTPUT_ON_FAILURE=1

set PATH=%SW_TOOLCHAIN_PATH%\usr\bin;%PATH%

if not defined VSCMD_VER call scripts\tools\vs-env.cmd -arch=x64 -host_arch=x64
if not defined GITHUB_ACTION goto :eof

echo ::set-env name=SW_FOUNDATION_REF::%SW_FOUNDATION_REF%
echo ::set-env name=SW_XCTEST_REF::%SW_XCTEST_REF%

echo ::set-env name=SW_LLVM_PROJECT_SOURCES_DIR::%SW_LLVM_PROJECT_SOURCES_DIR%
echo ::set-env name=SW_LLVM_SOURCES_DIR::%SW_LLVM_SOURCES_DIR%
echo ::set-env name=SW_SWIFT_SOURCES_DIR::%SW_SWIFT_SOURCES_DIR%
echo ::set-env name=SW_DISPATCH_SOURCES_DIR::%SW_DISPATCH_SOURCES_DIR%
echo ::set-env name=SW_FOUNDATION_SOURCES_DIR::%SW_FOUNDATION_SOURCES_DIR%
echo ::set-env name=SW_XCTEST_SOURCES_DIR::%SW_XCTEST_SOURCES_DIR%

echo ::set-env name=SW_LLVM_BUILD_DIR::%SW_LLVM_BUILD_DIR%
echo ::set-env name=SW_STDLIB_BUILD_DIR::%SW_STDLIB_BUILD_DIR%
echo ::set-env name=SW_DISPATCH_BUILD_DIR::%SW_DISPATCH_BUILD_DIR%
echo ::set-env name=SW_FOUNDATION_BUILD_DIR::%SW_FOUNDATION_BUILD_DIR%
echo ::set-env name=SW_XCTEST_BUILD_DIR::%SW_XCTEST_BUILD_DIR%

echo ::set-env name=SW_PLATFORM_PATH::%SW_PLATFORM_PATH%

echo ::set-env name=SW_SDK_PATH::%SW_SDK_PATH%
echo ::set-env name=SW_SDK_INSTALL_DIR::%SW_SDK_INSTALL_DIR%
echo ::set-env name=SW_XCTEST_INSTALL_PATH::%SW_XCTEST_INSTALL_PATH%

echo ::set-env name=SW_TOOLCHAIN_PATH::%SW_TOOLCHAIN_PATH%
echo ::set-env name=SW_CURL_PATH::%SW_CURL_PATH%
echo ::set-env name=SW_ICU_PATH::%SW_ICU_PATH%
echo ::set-env name=SW_XML2_PATH::%SW_XML2_PATH%
echo ::set-env name=SW_ZLIB_PATH::%SW_ZLIB_PATH%

echo ::set-env name=PATH::%PATH%

echo ::set-env name=CTEST_OUTPUT_ON_FAILURE::%CTEST_OUTPUT_ON_FAILURE%
