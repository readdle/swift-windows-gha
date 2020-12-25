
set "SW_LOG_TOOLCHAIN_INFO=%SW_LOG_INFO% --scope toolchain"
set "SW_LOG_TOOLCHAIN_WARNING=%SW_LOG_WARNING% --scope toolchain"

%SW_LOG_TOOLCHAIN_INFO% --message="Configuring build environment"

set SW_DISPATCH_REPO=%SW_SWIFT_SDK_SPEC%/swift-corelibs-libdispatch
set SW_DISPATCH_ORIGIN_URL=git://github.com/%SW_DISPATCH_REPO%.git

if %SW_SWIFT_SDK_SPEC%==readdle set SW_SDK_SPEC_PREFIX=readdle/

if defined SW_GIT_TAG (
  set SW_LLVM_REF=%SW_GIT_TAG%
  set SW_SWIFT_REF=%SW_GIT_TAG%
  set SW_CMARK_REF=%SW_GIT_TAG%
  :: We should respect global git tag for Apple repos, but not for Readdle repos.
  if defined SW_SDK_SPEC_PREFIX (
    call :sw_get_ref SW_DISPATCH_REF %SW_SDK_SPEC_PREFIX%  
  ) else (
    set SW_DISPATCH_REF=%SW_GIT_TAG%
  )
) else (
  call :sw_get_ref SW_LLVM_REF swift/
  call :sw_get_ref SW_SWIFT_REF
  call :sw_get_ref SW_CMARK_REF
  call :sw_get_ref SW_DISPATCH_REF %SW_SDK_SPEC_PREFIX%
)

set "SW_LLVM_PROJECT_SOURCES_DIR=%SW_SOURCES_DIR%\llvm-project"
set "SW_LLVM_SOURCES_DIR=%SW_LLVM_PROJECT_SOURCES_DIR%\llvm"
set "SW_CMARK_SOURCES_DIR=%SW_SOURCES_DIR%\cmark"
set "SW_SWIFT_SOURCES_DIR=%SW_SOURCES_DIR%\swift"
set "SW_DISPATCH_SOURCES_DIR=%SW_SOURCES_DIR%\swift-corelibs-libdispatch"

set "SW_LLVM_TOOLS_BUILD_DIR=%SW_BUILD_DIR%\llvm-tools"
set "SW_TOOLCHAIN_BUILD_DIR=%SW_BUILD_DIR%\toolchain"

set "SW_TOOLCHAIN_INSTALL_DIR=%SW_INSTALL_DIR%\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr"
set "SW_ICU_DIR=%SW_ARTIFACTS_DIR%\Library\icu-%SW_ICU_VERSION%"

set "SW_LLVM_TABLEGEN=%SW_LLVM_TOOLS_BUILD_DIR%\bin\llvm-tblgen.exe"
set "SW_CLANG_TABLEGEN=%SW_LLVM_TOOLS_BUILD_DIR%\bin\clang-tblgen.exe"
set "SW_LLDB_TABLEGEN=%SW_LLVM_TOOLS_BUILD_DIR%\bin\lldb-tblgen.exe"

%SW_LOG_TOOLCHAIN_INFO% --prefix="Dispatch origin:         " --message="%SW_DISPATCH_ORIGIN_URL%"
%SW_LOG_TOOLCHAIN_INFO% --prefix="LLVM ref:                " --message="%SW_LLVM_REF%"
%SW_LOG_TOOLCHAIN_INFO% --prefix="Dispatch ref:            " --message="%SW_DISPATCH_REF%"
%SW_LOG_TOOLCHAIN_INFO% --prefix="Swift ref:               " --message="%SW_SWIFT_REF%"
%SW_LOG_TOOLCHAIN_INFO%
%SW_LOG_TOOLCHAIN_INFO% --prefix="LLVM Project sources dir:" --message="%SW_LLVM_PROJECT_SOURCES_DIR%"
%SW_LOG_TOOLCHAIN_INFO% --prefix="LLVM sources dir:        " --message="%SW_LLVM_SOURCES_DIR%"
%SW_LOG_TOOLCHAIN_INFO% --prefix="cmark sources dir:       " --message="%SW_CMARK_SOURCES_DIR%"
%SW_LOG_TOOLCHAIN_INFO% --prefix="Swift sources dir:       " --message="%SW_SWIFT_SOURCES_DIR%"
%SW_LOG_TOOLCHAIN_INFO% --prefix="Dispatch sources dir:    " --message="%SW_DISPATCH_SOURCES_DIR%"
%SW_LOG_TOOLCHAIN_INFO%
%SW_LOG_TOOLCHAIN_INFO% --prefix="LLVM tools build dir:    " --message="%SW_LLVM_TOOLS_BUILD_DIR%"
%SW_LOG_TOOLCHAIN_INFO% --prefix="Toolchain build dir:     " --message="%SW_TOOLCHAIN_BUILD_DIR%"
%SW_LOG_TOOLCHAIN_INFO%
%SW_LOG_TOOLCHAIN_INFO% --prefix="Toolchain install dir:   " --message="%SW_TOOLCHAIN_INSTALL_DIR%"
%SW_LOG_TOOLCHAIN_INFO%
%SW_LOG_TOOLCHAIN_INFO% --prefix="ICU dir:                 " --message="%SW_ICU_DIR%"
%SW_LOG_TOOLCHAIN_INFO%
%SW_LOG_TOOLCHAIN_INFO% --prefix="LLVM tblgen:             " --message="%SW_LLVM_TABLEGEN%"
%SW_LOG_TOOLCHAIN_INFO% --prefix="CLANG tblgen:            " --message="%SW_CLANG_TABLEGEN%"
%SW_LOG_TOOLCHAIN_INFO% --prefix="LLDB tblgen:             " --message="%SW_LLDB_TABLEGEN%"
%SW_LOG_TOOLCHAIN_INFO%

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
