set "SW_LOG_SDK_INFO=%SW_LOG_INFO% --scope sdk"
set "SW_LOG_SDK_WARNING=%SW_LOG_WARNING% --scope sdk"

%SW_LOG_SDK_INFO% --message="Configuring build environment"

set SW_FOUNDATION_REPO=%SW_SWIFT_SDK_SPEC%/swift-corelibs-foundation
set SW_FOUNDATION_ORIGIN_URL=git://github.com/%SW_FOUNDATION_REPO%.git
set SW_DISPATCH_REPO=%SW_SWIFT_SDK_SPEC%/swift-corelibs-libdispatch
set SW_DISPATCH_ORIGIN_URL=git://github.com/%SW_DISPATCH_REPO%.git

if %SW_SWIFT_SDK_SPEC%==readdle set SW_SDK_SPEC_PREFIX=readdle/

if defined SW_GIT_TAG (
  set SW_LLVM_REF=%SW_GIT_TAG%
  set SW_SWIFT_REF=%SW_GIT_TAG%
  set SW_XCTEST_REF=%SW_GIT_TAG%
  if defined SW_SDK_SPEC_PREFIX (
    if not defined SW_DISPATCH_REF call :sw_get_ref SW_DISPATCH_REF %SW_SDK_SPEC_PREFIX%
    call :sw_get_ref SW_FOUNDATION_REF %SW_SDK_SPEC_PREFIX%
  ) else (
    set SW_DISPATCH_REF=%SW_GIT_TAG%
    set SW_FOUNDATION_REF=%SW_GIT_TAG%    
  )
) else (
  if not defined SW_LLVM_REF call :sw_get_ref SW_LLVM_REF swift/
  if not defined SW_SWIFT_REF call :sw_get_ref SW_SWIFT_REF
  if not defined SW_DISPATCH_REF call :sw_get_ref SW_DISPATCH_REF %SW_SDK_SPEC_PREFIX%
  call :sw_get_ref SW_FOUNDATION_REF %SW_SDK_SPEC_PREFIX%
  call :sw_get_ref SW_XCTEST_REF
)

set "SW_LLVM_PROJECT_SOURCES_DIR=%SW_SOURCES_DIR%\llvm-project"
set "SW_LLVM_SOURCES_DIR=%SW_LLVM_PROJECT_SOURCES_DIR%\llvm"
set "SW_SWIFT_SOURCES_DIR=%SW_SOURCES_DIR%\swift"
set "SW_DISPATCH_SOURCES_DIR=%SW_SOURCES_DIR%\swift-corelibs-libdispatch"
set "SW_FOUNDATION_SOURCES_DIR=%SW_SOURCES_DIR%\swift-corelibs-foundation"
set "SW_XCTEST_SOURCES_DIR=%SW_SOURCES_DIR%\swift-corelibs-xctest"

set "SW_LLVM_BUILD_DIR=%SW_BUILD_DIR%\llvm"
set "SW_STDLIB_BUILD_DIR=%SW_BUILD_DIR%\swift-stdlib"
set "SW_DISPATCH_BUILD_DIR=%SW_BUILD_DIR%\libdispatch"
set "SW_FOUNDATION_BUILD_DIR=%SW_BUILD_DIR%\foundation"
set "SW_XCTEST_BUILD_DIR=%SW_BUILD_DIR%\xctest"

set "SW_PLATFORM_DIR=%SW_INSTALL_DIR%\Library\Developer\Platforms\Windows.platform"
set "SW_SDK_DIR=%SW_PLATFORM_DIR%\Developer\SDKs\Windows.sdk"

set "SW_SDK_INSTALL_DIR=%SW_SDK_DIR%\usr"
set "SW_XCTEST_INSTALL_DIR=%SW_PLATFORM_DIR%\Developer\Library\XCTest-development\usr"

set "SW_TOOLCHAIN_DIR=%SW_ARTIFACTS_DIR%\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain"
set "SW_CURL_DIR=%SW_ARTIFACTS_DIR%\Library\libcurl-%SW_CURL_VERSION%"
set "SW_ICU_DIR=%SW_ARTIFACTS_DIR%\Library\icu-%SW_ICU_VERSION%"
set "SW_XML2_DIR=%SW_ARTIFACTS_DIR%\Library\libxml2-%SW_XML2_VERSION%"
set "SW_ZLIB_DIR=%SW_ARTIFACTS_DIR%\Library\zlib-%SW_ZLIB_VERSION%"

set CTEST_OUTPUT_ON_FAILURE=1

set "PATH=%SW_TOOLCHAIN_DIR%\usr\bin;%PATH%"

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
%SW_LOG_SDK_INFO% --prefix="LLVM build dir:          " --message="%SW_LLVM_BUILD_DIR%"
%SW_LOG_SDK_INFO% --prefix="StdLib build dir:        " --message="%SW_STDLIB_BUILD_DIR%"
%SW_LOG_SDK_INFO% --prefix="Dispatch build dir:      " --message="%SW_DISPATCH_BUILD_DIR%"
%SW_LOG_SDK_INFO% --prefix="Foundation build dir:    " --message="%SW_FOUNDATION_BUILD_DIR%"
%SW_LOG_SDK_INFO% --prefix="XCTest build dir:        " --message="%SW_XCTEST_BUILD_DIR%"
%SW_LOG_SDK_INFO%
%SW_LOG_SDK_INFO% --prefix="SDK install dir:         " --message="%SW_SDK_INSTALL_DIR%"
%SW_LOG_SDK_INFO% --prefix="XCTest install dir:      " --message="%SW_XCTEST_INSTALL_DIR%"
%SW_LOG_SDK_INFO%
%SW_LOG_SDK_INFO% --prefix="Toolchain dir:           " --message="%SW_TOOLCHAIN_DIR%"
%SW_LOG_SDK_INFO% --prefix="CURL dir:                " --message="%SW_CURL_DIR%"
%SW_LOG_SDK_INFO% --prefix="ICU dir:                 " --message="%SW_ICU_DIR%"
%SW_LOG_SDK_INFO% --prefix="XML2 dir:                " --message="%SW_XML2_DIR%"
%SW_LOG_SDK_INFO% --prefix="ZLIB dir:                " --message="%SW_ZLIB_DIR%"
%SW_LOG_SDK_INFO%
%SW_LOG_SDK_INFO% --prefix="PATH:                    " --message="%PATH%"
%SW_LOG_SDK_INFO%

exit /b 0


rem ###########################################################################
:sw_get_ref <result_var> <prefix>
setlocal enabledelayedexpansion

set PREFIX=%2

if %SW_SWIFT_BRANCH_SPEC%==5.3 (
  set REF=%PREFIX%release/5.3
) else if %SW_SWIFT_BRANCH_SPEC%==5.4 (
  set REF=%PREFIX%release/5.4
) else (
  set REF=%PREFIX%main
)

endlocal && set %1=%REF%
exit /b
