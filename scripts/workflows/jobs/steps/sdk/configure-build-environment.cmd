%SW_SET_ENV% SW_LOG_SDK_INFO "%SW_LOG_INFO% --scope sdk"
%SW_SET_ENV% SW_LOG_SDK_WARNING "%SW_LOG_WARNING% --scope sdk"

%SW_LOG_SDK_INFO% --message="Configuring build environment"

call scripts\tools\set-env.cmd SW_DISPATCH_REPO apple/swift-corelibs-libdispatch
call scripts\tools\set-env.cmd SW_DISPATCH_ORIGIN_URL git://github.com/%SW_DISPATCH_REPO%.git
call scripts\tools\set-env.cmd SW_FOUNDATION_REPO apple/swift-corelibs-foundation
call scripts\tools\set-env.cmd SW_FOUNDATION_ORIGIN_URL git://github.com/%SW_FOUNDATION_REPO%.git

if [%SW_SWIFT_BRANCH_SPEC%]==[5.3] (
  if not defined SW_LLVM_REF call scripts\tools\set-env.cmd SW_LLVM_REF swift/release/5.3
  if not defined SW_DISPATCH_REF call scripts\tools\set-env.cmd SW_DISPATCH_REF release/5.3
  if not defined SW_SWIFT_REF call scripts\tools\set-env.cmd SW_SWIFT_REF release/5.3

  call scripts\tools\set-env.cmd SW_FOUNDATION_REF release/5.3
  call scripts\tools\set-env.cmd SW_XCTEST_REF release/5.3
) else (
  if not defined SW_LLVM_REF call scripts\tools\set-env.cmd SW_LLVM_REF swift/main
  if not defined SW_DISPATCH_REF call scripts\tools\set-env.cmd SW_DISPATCH_REF main
  if not defined SW_SWIFT_REF call scripts\tools\set-env.cmd SW_SWIFT_REF main

  call scripts\tools\set-env.cmd SW_FOUNDATION_REF main
  call scripts\tools\set-env.cmd SW_XCTEST_REF main
)

if [%SW_SWIFT_SDK_SPEC%]==[readdle] (
  call scripts\tools\set-env.cmd SW_FOUNDATION_REPO readdle/swift-corelibs-foundation
  call scripts\tools\set-env.cmd SW_FOUNDATION_ORIGIN_URL git://github.com/!SW_FOUNDATION_REPO!.git
  call scripts\tools\set-env.cmd SW_FOUNDATION_REF swift-windows-dev-branch

  call scripts\tools\set-env.cmd SW_DISPATCH_REPO readdle/swift-corelibs-libdispatch
  call scripts\tools\set-env.cmd SW_DISPATCH_ORIGIN_URL git://github.com/!SW_DISPATCH_REPO!.git
  if not defined SW_DISPATCH_REF call scripts\tools\set-env.cmd SW_DISPATCH_REF swift-dev-windows-readdle
)

call scripts\tools\set-env.cmd SW_LLVM_PROJECT_SOURCES_DIR %SW_SOURCES_DIR%\llvm-project
call scripts\tools\set-env.cmd SW_LLVM_SOURCES_DIR %SW_LLVM_PROJECT_SOURCES_DIR%\llvm
call scripts\tools\set-env.cmd SW_SWIFT_SOURCES_DIR %SW_SOURCES_DIR%\swift
call scripts\tools\set-env.cmd SW_DISPATCH_SOURCES_DIR %SW_SOURCES_DIR%\swift-corelibs-libdispatch
call scripts\tools\set-env.cmd SW_FOUNDATION_SOURCES_DIR %SW_SOURCES_DIR%\swift-corelibs-foundation
call scripts\tools\set-env.cmd SW_XCTEST_SOURCES_DIR %SW_SOURCES_DIR%\swift-corelibs-xctest

call scripts\tools\set-env.cmd SW_LLVM_BUILD_DIR %SW_BUILD_DIR%\llvm
call scripts\tools\set-env.cmd SW_STDLIB_BUILD_DIR %SW_BUILD_DIR%\swift-stdlib
call scripts\tools\set-env.cmd SW_DISPATCH_BUILD_DIR %SW_BUILD_DIR%\libdispatch
call scripts\tools\set-env.cmd SW_FOUNDATION_BUILD_DIR %SW_BUILD_DIR%\foundation
call scripts\tools\set-env.cmd SW_XCTEST_BUILD_DIR %SW_BUILD_DIR%\xctest

call scripts\tools\set-env.cmd SW_PLATFORM_PATH=%SW_INSTALL_DIR%\Library\Developer\Platforms\Windows.platform
call scripts\tools\set-env.cmd SW_SDK_PATH=%SW_PLATFORM_PATH%\Developer\SDKs\Windows.sdk

call scripts\tools\set-env.cmd SW_SDK_INSTALL_DIR %SW_SDK_PATH%\usr
call scripts\tools\set-env.cmd SW_XCTEST_INSTALL_PATH %SW_PLATFORM_PATH%\Developer\Library\XCTest-development\usr

call scripts\tools\set-env.cmd SW_TOOLCHAIN_PATH %SW_ARTIFACTS_DIR%\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain
call scripts\tools\set-env.cmd SW_CURL_PATH %SW_ARTIFACTS_DIR%\Library\libcurl-%SW_CURL_VERSION%
call scripts\tools\set-env.cmd SW_ICU_PATH %SW_ARTIFACTS_DIR%\Library\icu-%SW_ICU_VERSION%
call scripts\tools\set-env.cmd SW_XML2_PATH %SW_ARTIFACTS_DIR%\Library\libxml2-%SW_XML2_VERSION%
call scripts\tools\set-env.cmd SW_ZLIB_PATH %SW_ARTIFACTS_DIR%\Library\zlib-%SW_ZLIB_VERSION%

call scripts\tools\set-env.cmd CTEST_OUTPUT_ON_FAILURE 1

call scripts\tools\set-env.cmd PATH "%SW_TOOLCHAIN_PATH%\usr\bin;%PATH%"

%SW_LOG_SDK_INFO% --prefix="Dispatch origin:         " --message="%SW_DISPATCH_ORIGIN_URL%"
%SW_LOG_SDK_INFO% --prefix="Foundation origin:       " --message="%SW_FOUNDATION_ORIGIN_URL%"
%SW_LOG_SDK_INFO% --prefix="LLVM ref:                " --message="%SW_LLVM_REF%"
%SW_LOG_SDK_INFO% --prefix="Dispatch ref:            " --message="%SW_DISPATCH_REF%"
%SW_LOG_SDK_INFO% --prefix="Swift ref:               " --message="%SW_SWIFT_REF%"
%SW_LOG_SDK_INFO% --prefix="Foundation ref:          " --message="%SW_FOUNDATION_REF%"
%SW_LOG_SDK_INFO% --prefix="XCTest ref:              " --message="%SW_XCTEST_REF%"
%SW_LOG_SDK_INFO%
%SW_LOG_SDK_INFO% --prefix="LLVM Project sources dir:" --message="%SW_LLVM_PROJECT_SOURCES_DIR%"
%SW_LOG_SDK_INFO% --prefix="LLVM sources dir:        " --message="%SW_LLVM_SOURCES_DIR%"
%SW_LOG_SDK_INFO% --prefix="Swift sources dir:       " --message="%SW_SWIFT_SOURCES_DIR%"
%SW_LOG_SDK_INFO% --prefix="Dispatch sources dir:    " --message="%SW_DISPATCH_SOURCES_DIR%"
%SW_LOG_SDK_INFO% --prefix="Foundation sources dir:  " --message="%SW_FOUNDATION_SOURCES_DIR%"
%SW_LOG_SDK_INFO% --prefix="XCTest sources dir:      " --message="%SW_XCTEST_SOURCES_DIR%"
%SW_LOG_SDK_INFO%
%SW_LOG_SDK_INFO% --prefix="LLVB build dir:          " --message="%SW_LLVM_BUILD_DIR%"
%SW_LOG_SDK_INFO% --prefix="StdLib build dir:        " --message="%SW_STDLIB_BUILD_DIR%"
%SW_LOG_SDK_INFO% --prefix="Dispatch build dir:      " --message="%SW_DISPATCH_BUILD_DIR%"
%SW_LOG_SDK_INFO% --prefix="Foundation build dir:    " --message="%SW_FOUNDATION_BUILD_DIR%"
%SW_LOG_SDK_INFO% --prefix="XCTest build dir:        " --message="%SW_XCTEST_BUILD_DIR%"
%SW_LOG_SDK_INFO%
%SW_LOG_SDK_INFO% --prefix="SDK install dir:         " --message="%SW_SDK_INSTALL_DIR%"
%SW_LOG_SDK_INFO% --prefix="XCTest install dir:      " --message="%SW_XCTEST_INSTALL_PATH%"
%SW_LOG_SDK_INFO%
%SW_LOG_SDK_INFO% --prefix="Toolchain dir:           " --message="%SW_TOOLCHAIN_PATH%"
%SW_LOG_SDK_INFO% --prefix="CURL dir:                " --message="%SW_CURL_PATH%"
%SW_LOG_SDK_INFO% --prefix="ICU dir:                 " --message="%SW_ICU_PATH%"
%SW_LOG_SDK_INFO% --prefix="XML2 dir:                " --message="%SW_XML2_PATH%"
%SW_LOG_SDK_INFO% --prefix="ZLIB dir:                " --message="%SW_ZLIB_PATH%"
%SW_LOG_SDK_INFO%
%SW_LOG_SDK_INFO% --prefix="PATH:                    " --message="%PATH%"
%SW_LOG_SDK_INFO%
