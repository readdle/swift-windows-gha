set "SW_LOG_JOB_INFO=%SW_LOG_INFO% --scope tools"
set "SW_LOG_JOB_WARNING=%SW_LOG_WARNING% --scope tools"

%SW_LOG_JOB_INFO% --message="Configuring build environment"

set SW_DISPATCH_REPO=%SW_SWIFT_SDK_SPEC%/swift-corelibs-libdispatch
set SW_DISPATCH_ORIGIN_URL=https://github.com/%SW_DISPATCH_REPO%.git

if %SW_SWIFT_SDK_SPEC%==readdle set SW_SDK_SPEC_PREFIX=readdle/

if defined SW_GIT_TAG (
  set SW_LLVM_REF=%SW_GIT_TAG%
  set SW_SWIFT_REF=%SW_GIT_TAG%
  set SW_CMARK_REF=%SW_GIT_TAG%
  set SW_SWIFT_SYNTAX_REF=%SW_GIT_TAG%
  :: We should respect global git tag for Apple repos, but not for Readdle repos.
  if defined SW_SDK_SPEC_PREFIX (
    call :sw_get_ref SW_DISPATCH_REF %SW_SDK_SPEC_PREFIX%  
  ) else (
    set SW_DISPATCH_REF=%SW_GIT_TAG%
  )
) else (
  call :sw_get_llvm_ref SW_LLVM_REF
  call :sw_get_ref SW_SWIFT_REF
  call :sw_get_cmark_ref SW_CMARK_REF
  call :sw_get_ref SW_SWIFT_SYNTAX_REF
  call :sw_get_ref SW_DISPATCH_REF %SW_SDK_SPEC_PREFIX%
)

set "SW_LLVM_PROJECT_SOURCES_DIR=%SW_SOURCES_DIR%\llvm-project"
set "SW_LLVM_SOURCES_DIR=%SW_LLVM_PROJECT_SOURCES_DIR%\llvm"
set "SW_CMARK_SOURCES_DIR=%SW_SOURCES_DIR%\cmark"
set "SW_SWIFT_SOURCES_DIR=%SW_SOURCES_DIR%\swift"
set "SW_SWIFT_SYNTAX_SOURCES_DIR=%SW_SOURCES_DIR%\swift-syntax"
set "SW_DISPATCH_SOURCES_DIR=%SW_SOURCES_DIR%\swift-corelibs-libdispatch"

set "SW_TOOLS_BUILD_DIR=%SW_BUILD_DIR%\tools"

%SW_LOG_JOB_INFO% --prefix="Dispatch origin:         " --message="%SW_DISPATCH_ORIGIN_URL%"
%SW_LOG_JOB_INFO% --prefix="Dispatch ref:            " --message="%SW_DISPATCH_REF%"
%SW_LOG_JOB_INFO% --prefix="cmark ref:               " --message="%SW_CMARK_REF%"
%SW_LOG_JOB_INFO% --prefix="swift-syntax ref:        " --message="%SW_SWIFT_SYNTAX_REF%"
%SW_LOG_JOB_INFO% --prefix="LLVM ref:                " --message="%SW_LLVM_REF%"
%SW_LOG_JOB_INFO% --prefix="Swift ref:               " --message="%SW_SWIFT_REF%"

%SW_LOG_JOB_INFO%
%SW_LOG_JOB_INFO% --prefix="LLVM Project sources dir:" --message="%SW_LLVM_PROJECT_SOURCES_DIR%"
%SW_LOG_JOB_INFO% --prefix="LLVM sources dir:        " --message="%SW_LLVM_SOURCES_DIR%"
%SW_LOG_JOB_INFO% --prefix="cmark sources dir:       " --message="%SW_CMARK_SOURCES_DIR%"
%SW_LOG_JOB_INFO% --prefix="Swift sources dir:       " --message="%SW_SWIFT_SOURCES_DIR%"
%SW_LOG_JOB_INFO% --prefix="Dispatch sources dir:    " --message="%SW_DISPATCH_SOURCES_DIR%"
%SW_LOG_JOB_INFO% --prefix="swift-syntax sources dir:" --message="%SW_SWIFT_SYNTAX_SOURCES_DIR%"
%SW_LOG_JOB_INFO%
%SW_LOG_JOB_INFO% --prefix="Tools build dir:         " --message="%SW_TOOLS_BUILD_DIRs%"

exit /b 0

rem ###########################################################################
:sw_get_ref <result_var> <prefix>
setlocal enabledelayedexpansion

set PREFIX=%2

if %SW_SWIFT_BRANCH_SPEC%==5.3 (
  set REF=%PREFIX%release/5.3
) else if %SW_SWIFT_BRANCH_SPEC%==5.4 (
  set REF=%PREFIX%release/5.4
) else if %SW_SWIFT_BRANCH_SPEC%==5.5 (
  set REF=%PREFIX%release/5.5
) else (
  set REF=%PREFIX%main
)

endlocal && set %1=%REF%
exit /b

rem ###########################################################################
:sw_get_llvm_ref <result_var>
setlocal enabledelayedexpansion

if %SW_SWIFT_BRANCH_SPEC%==main (
  set REF=stable/20220421
) else (
  call :sw_get_ref REF swift/
)

endlocal && set %1=%REF%
exit /b

rem ###########################################################################
:sw_get_cmark_ref <result_var>
setlocal enabledelayedexpansion

if %SW_SWIFT_BRANCH_SPEC%==main (
  set REF=gfm
) else (
  call :sw_get_ref REF
)

endlocal && set %1=%REF%
exit /b
