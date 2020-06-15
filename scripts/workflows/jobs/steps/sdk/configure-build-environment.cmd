call scripts\tools\vs-env.cmd -arch=x64 -host_arch=x64

if [%SW_SWIFT_BRANCH_SPEC%]==[5.2] (
  if not defined SW_LLVM_REF set SW_LLVM_REF swift/swift-5.2-branch
  if not defined SW_DISPATCH_REF set SW_DISPATCH_REF swift-5.2-branch
  if not defined SW_SWIFT_REF set SW_SWIFT_REF swift-5.2-branch

  call scripts\tools\set-env.cmd SW_FOUNDATION_REF swift-5.2-branch
  call scripts\tools\set-env.cmd SW_XCTEST_REF swift-5.2-branch
) else if [%SW_SWIFT_BRANCH_SPEC%]==[5.3] (
  if not defined SW_LLVM_REF call scripts\tools\set-env.cmd SW_LLVM_REF swift/release/5.3
  if not defined SW_DISPATCH_REF call scripts\tools\set-env.cmd SW_DISPATCH_REF release/5.3
  if not defined SW_SWIFT_REF call scripts\tools\set-env.cmd SW_SWIFT_REF release/5.3

  call scripts\tools\set-env.cmd SW_FOUNDATION_REF release/5.3
  call scripts\tools\set-env.cmd SW_XCTEST_REF release/5.3
) else (
  if not defined SW_LLVM_REF call scripts\tools\set-env.cmd SW_LLVM_REF swift/master
  if not defined SW_DISPATCH_REF call scripts\tools\set-env.cmd SW_DISPATCH_REF master
  if not defined SW_SWIFT_REF call scripts\tools\set-env.cmd SW_SWIFT_REF master

  call scripts\tools\set-env.cmd SW_FOUNDATION_REF master
  call scripts\tools\set-env.cmd SW_XCTEST_REF master
)

call scripts\tools\set-env.cmd SW_LLVM_PROJECT_SOURCES_DIR %SW_SOURCES_DIR%\llvm-project
call scripts\tools\set-env.cmd SW_LLVM_SOURCES_DIR %SW_LLVM_PROJECT_SOURCES_DIR%\llvm
call scripts\tools\set-env.cmd SW_SWIFT_SOURCES_DIR %SW_LLVM_PROJECT_SOURCES_DIR%\swift
call scripts\tools\set-env.cmd SW_DISPATCH_SOURCES_DIR %SW_SOURCES_DIR%\swift-corelibs-libdispatch
call scripts\tools\set-env.cmd SW_FOUNDATION_SOURCES_DIR %SW_SOURCES_DIR%\swift-corelibs-foundation
call scripts\tools\set-env.cmd SW_XCTEST_SOURCES_DIR %SW_SOURCES_DIR%\swift-corelibs-xctest

call scripts\tools\set-env.cmd SW_LLVM_BUILD_DIR %SW_BUILD_DIR%\llvm
call scripts\tools\set-env.cmd SW_STDLIB_BUILD_DIR %SW_BUILD_DIR%\swift-stdlib
call scripts\tools\set-env.cmd SW_DISPATCH_BUILD_DIR %SW_BUILD_DIR%\libdispatch
call scripts\tools\set-env.cmd SW_FOUNDATION_BUILD_DIR %SW_BUILD_DIR%\foundation
call scripts\tools\set-env.cmd SW_XCTEST_BUILD_DIR %SW_BUILD_DIR%\xctest

call scripts\tools\set-env.cmd SW_PLATFORM_PATH %SW_INSTALL_DIR%\Library\Developer\Platforms\Windows.platform

call scripts\tools\set-env.cmd SW_SDK_PATH %SW_PLATFORM_PATH%\Developer\SDKs\Windows.sdk
call scripts\tools\set-env.cmd SW_SDK_INSTALL_DIR %SW_SDK_PATH%\usr
call scripts\tools\set-env.cmd SW_XCTEST_INSTALL_PATH %SW_PLATFORM_PATH%\Developer\Library\XCTest-development\usr

call scripts\tools\set-env.cmd SW_TOOLCHAIN_PATH %SW_ARTIFACTS_DIR%\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain
call scripts\tools\set-env.cmd SW_CURL_PATH %SW_ARTIFACTS_DIR%\Library\libcurl-%SW_CURL_VERSION%
call scripts\tools\set-env.cmd SW_ICU_PATH %SW_ARTIFACTS_DIR%\Library\icu-%SW_ICU_VERSION%
call scripts\tools\set-env.cmd SW_XML2_PATH %SW_ARTIFACTS_DIR%\Library\libxml2-%SW_XML2_VERSION%
call scripts\tools\set-env.cmd SW_ZLIB_PATH %SW_ARTIFACTS_DIR%\Library\zlib-%SW_ZLIB_VERSION%

call scripts\tools\set-env.cmd CTEST_OUTPUT_ON_FAILURE 1

call scripts\tools\set-env.cmd PATH "%SW_TOOLCHAIN_PATH%\usr\bin;%PATH%"
