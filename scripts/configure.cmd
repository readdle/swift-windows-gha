@echo off

setlocal enabledelayedexpansion

call "%~dp0\tools\init-log.cmd"

set SW_LOG_INFO=%SW_LOG_INFO% --scope config
set SW_LOG_ERROR=%SW_LOG_ERROR% --scope config
set SW_LOG_WARNING=%SW_LOG_WARNING% --scope config

set SW_INTERACTIVE=YES

set SW_SWIFT_BRANCH_SPEC=main
set SW_SWIFT_SDK_SPEC=apple
set SW_SOURCES_DIR=%CD%\w\s
set SW_BUILD_DIR=%CD%\w\b
set SW_INSTALL_DIR=%CD%\w\i
set SW_OBJC_PATCH_ENABLED=NO
set SW_STDLIB_PATCH_ENABLED=NO
set SW_SKIP_ICU=NO
set SW_SKIP_TOOLCHAIN=NO
set SW_SKIP_TOOLCHAIN_SWIFT_TEST=NO
set SW_SKIP_ZLIB=NO
set SW_SKIP_XML2=NO
set SW_SKIP_CURL=NO
set SW_SKIP_SDK=NO
set SW_SKIP_SDK_CHECKOUT=NO
set SW_SKIP_SDK_STDLIB=NO
set SW_SKIP_SDK_DISPATCH=NO
set SW_SKIP_SDK_FOUNDATION=NO
set SW_SKIP_SDK_XCTEST=NO
set SW_SKIP_SDK_DISPATCH_TEST=NO
set SW_SKIP_SDK_FOUNDATION_TEST=NO
set SW_SKIP_SQLITE=YES
set SW_SKIP_DEVTOOLS=YES
set SW_GIT_TAG=

set SW_ICU_VERSION=67
set SW_CURL_VERSION=development
set SW_XML2_VERSION=development
set SW_ZLIB_VERSION=1.2.11
set SW_SQLITE_RELEASE=3340000
set SW_SQLITE_VERSION=3.34.0

set SW_CONFIG_FILE=%CD%\config.cmd

if defined pythonLocation (
  set SW_PYTHON_DIR=%pythonLocation%
) else (
  set SW_PYTHON_DIR=C:\Python
)
call :sw_parse_arguments %* && call :sw_validate_parameters
if errorlevel 1 goto :eof

if "%SW_INTERACTIVE%"=="NO" (
  %SW_LOG_INFO% --message="Non-interactive mode"
  goto configure
) else (
  %SW_LOG_INFO% --message="Interactive mode"
)

if /i "%SW_SWIFT_BRANCH_SPEC%"=="main" (
  set SW_BRANCH_NUM=1
) else if /i "%SW_SWIFT_BRANCH_SPEC%"=="5.5" (
  set SW_BRANCH_NUM=2
) else if /i "%SW_SWIFT_BRANCH_SPEC%"=="5.4" (
  set SW_BRANCH_NUM=3
) else if /i "%SW_SWIFT_BRANCH_SPEC%"=="5.3" (
  set SW_BRANCH_NUM=4
)

if /i "%SW_SWIFT_SDK_SPEC%"=="apple" (
  set SW_SWIFT_SDK_SPEC_NUM=1
) else if /i "%SW_SWIFT_SDK_SPEC%"=="readdle" (
  set SW_SWIFT_SDK_SPEC_NUM=2
)

set SW_DEFAULT_JOBS_CONFIGURATION=Y
set SW_DEFAULT_TOOLCHAIN_CONFIGURATION=Y
set SW_DEFAULT_SDK_CONFIGURATION=Y
set SW_DEFAULT_DEVTOOLS_CONFIGURATION=Y

:sw_wizard_start

call :sw_normalize_parameters_for_wizard

call :sw_ask_branch
call :sw_ask_sdk_spec
call :sw_ask_git_tag
call :sw_ask_directories
call :sw_ask_swift_patch
call :sw_ask_stdlib_patch
call :sw_ask_fine_tune
call :sw_ask_config_file

:configure

if not defined SW_ARTIFACTS_DIR set SW_ARTIFACTS_DIR=%SW_INSTALL_DIR%

call :sw_normalize_parameters_for_saving

%SW_LOG_INFO%
%SW_LOG_INFO% --prefix="Swift branch spec:       " --message="%SW_SWIFT_BRANCH_SPEC%"
%SW_LOG_INFO% --prefix="Swift SDK spec:          " --message="%SW_SWIFT_SDK_SPEC%"
%SW_LOG_INFO% --prefix="Source files directory:  " --message="%SW_SOURCES_DIR%"
%SW_LOG_INFO% --prefix="Build output directory:  " --message="%SW_BUILD_DIR%"
%SW_LOG_INFO% --prefix="Install directory:       " --message="%SW_INSTALL_DIR%"
%SW_LOG_INFO% --prefix="Artifacts directory:     " --message="%SW_ARTIFACTS_DIR%"
%SW_LOG_INFO% --prefix="Python directory:        " --message="%SW_PYTHON_DIR%"
%SW_LOG_INFO%
%SW_LOG_INFO% --prefix="CURL version:            " --message="%SW_CURL_VERSION%"
%SW_LOG_INFO% --prefix="ICU version:             " --message="%SW_ICU_VERSION%"
%SW_LOG_INFO% --prefix="XML2 version:            " --message="%SW_XML2_VERSION%"
%SW_LOG_INFO% --prefix="ZLIB version:            " --message="%SW_ZLIB_VERSION%"
%SW_LOG_INFO% --prefix="SQLite version:          " --message="%SW_SQLITE_VERSION% (%SW_SQLITE_RELEASE%)"
%SW_LOG_INFO% --prefix="Git tag:                 " --message="%SW_GIT_TAG%"
%SW_LOG_INFO%
%SW_LOG_INFO% --prefix="Swift @objc patch:       " --message="%SW_OBJC_PATCH_ENABLED%"
%SW_LOG_INFO% --prefix="Swift print patch:       " --message="%SW_STDLIB_PATCH_ENABLED%"
%SW_LOG_INFO%
%SW_LOG_INFO% --prefix="Configuration file:      " --message="%SW_CONFIG_FILE%"
%SW_LOG_INFO%
if "%SW_SKIP_ICU%"=="YES"                  ( %SW_LOG_INFO% --prefix="Job disabled:            " --message="ICU" )
if "%SW_SKIP_TOOLCHAIN%"=="YES"            ( %SW_LOG_INFO% --prefix="Job disabled:            " --message="Toolchain" )
if "%SW_SKIP_TOOLCHAIN_SWIFT_TEST%"=="YES" ( %SW_LOG_INFO% --prefix="Step disabled:           " --message="Toolchain - Configure Test Environment" )
if "%SW_SKIP_TOOLCHAIN_SWIFT_TEST%"=="YES" ( %SW_LOG_INFO% --prefix="Step disabled:           " --message="Toolchain - Test Swift" )
if "%SW_SKIP_ZLIB%"=="YES"                 ( %SW_LOG_INFO% --prefix="Job disabled:            " --message="zlib" )
if "%SW_SKIP_XML2%"=="YES"                 ( %SW_LOG_INFO% --prefix="Job disabled:            " --message="libxml2" )
if "%SW_SKIP_CURL%"=="YES"                 ( %SW_LOG_INFO% --prefix="Job disabled:            " --message="curl" )
if "%SW_SKIP_SDK%"=="YES"                  ( %SW_LOG_INFO% --prefix="Job disabled:            " --message="SDK" )
if "%SW_SKIP_SDK_CHECKOUT%"=="YES"         ( %SW_LOG_INFO% --prefix="Step disabled:           " --message="SDK - Checkout Foundation" )
if "%SW_SKIP_SDK_CHECKOUT%"=="YES"         ( %SW_LOG_INFO% --prefix="Step disabled:           " --message="SDK - Checkout XCTest" )
if "%SW_SKIP_SDK_CHECKOUT%"=="YES"         ( %SW_LOG_INFO% --prefix="Step disabled:           " --message="SDK - Patch StdLib" )
if "%SW_SKIP_SDK_STDLIB%"=="YES"           ( %SW_LOG_INFO% --prefix="Step disabled:           " --message="SDK - Configure llvm" )
if "%SW_SKIP_SDK_STDLIB%"=="YES"           ( %SW_LOG_INFO% --prefix="Step disabled:           " --message="SDK - Configure StdLib" )
if "%SW_SKIP_SDK_STDLIB%"=="YES"           ( %SW_LOG_INFO% --prefix="Step disabled:           " --message="SDK - Build StdLib" )
if "%SW_SKIP_SDK_DISPATCH%"=="YES"         ( %SW_LOG_INFO% --prefix="Step disabled:           " --message="SDK - Configure libdispatch" )
if "%SW_SKIP_SDK_DISPATCH%"=="YES"         ( %SW_LOG_INFO% --prefix="Step disabled:           " --message="SDK - Build libdispatch" )
if "%SW_SKIP_SDK_FOUNDATION%"=="YES"       ( %SW_LOG_INFO% --prefix="Step disabled:           " --message="SDK - Configure Foundation" )
if "%SW_SKIP_SDK_FOUNDATION%"=="YES"       ( %SW_LOG_INFO% --prefix="Step disabled:           " --message="SDK - Build Foundation" )
if "%SW_SKIP_SDK_XCTEST%"=="YES"           ( %SW_LOG_INFO% --prefix="Step disabled:           " --message="SDK - Configure XCTest" )
if "%SW_SKIP_SDK_XCTEST%"=="YES"           ( %SW_LOG_INFO% --prefix="Step disabled:           " --message="SDK - Build XCTest" )
if "%SW_SKIP_SDK_STDLIB%"=="YES"           ( %SW_LOG_INFO% --prefix="Step disabled:           " --message="SDK - Install StdLib" )
if "%SW_SKIP_SDK_DISPATCH%"=="YES"         ( %SW_LOG_INFO% --prefix="Step disabled:           " --message="SDK - Install libdispatch" )
if "%SW_SKIP_SDK_FOUNDATION%"=="YES"       ( %SW_LOG_INFO% --prefix="Step disabled:           " --message="SDK - Install Foundation" )
if "%SW_SKIP_SDK_XCTEST%"=="YES"           ( %SW_LOG_INFO% --prefix="Step disabled:           " --message="SDK - Install XCTest" )
if "%SW_SKIP_SDK_DISPATCH_TEST%"=="YES"    ( %SW_LOG_INFO% --prefix="Step disabled:           " --message="SDK - Configure libdispatch Tests" )
if "%SW_SKIP_SDK_DISPATCH_TEST%"=="YES"    ( %SW_LOG_INFO% --prefix="Step disabled:           " --message="SDK - Build libdispatch Tests" )
if "%SW_SKIP_SDK_DISPATCH_TEST%"=="YES"    ( %SW_LOG_INFO% --prefix="Step disabled:           " --message="SDK - Test libdispatch" )
if "%SW_SKIP_SDK_FOUNDATION_TEST%"=="YES"  ( %SW_LOG_INFO% --prefix="Step disabled:           " --message="SDK - Configure Foundation Test Environment" )
if "%SW_SKIP_SDK_FOUNDATION_TEST%"=="YES"  ( %SW_LOG_INFO% --prefix="Step disabled:           " --message="SDK - Configure Foundation Tests" )
if "%SW_SKIP_SDK_FOUNDATION_TEST%"=="YES"  ( %SW_LOG_INFO% --prefix="Step disabled:           " --message="SDK - Build Foundation Tests" )
if "%SW_SKIP_SDK_FOUNDATION_TEST%"=="YES"  ( %SW_LOG_INFO% --prefix="Step disabled:           " --message="SDK - Test Foundation (CTest)" )
if "%SW_SKIP_SDK_FOUNDATION_TEST%"=="YES"  ( %SW_LOG_INFO% --prefix="Step disabled:           " --message="SDK - Test Foundation (XCTest)" )
if "%SW_SKIP_SQLITE%"=="YES"               ( %SW_LOG_INFO% --prefix="Job disabled:            " --message="SQLite" )
if "%SW_SKIP_DEVTOOLS%"=="YES"             ( %SW_LOG_INFO% --prefix="Job disabled:            " --message="DevTools" )
if "%SW_SWIFT_SDK_SPEC%"=="readdle" if not "%SW_SWIFT_BRANCH_SPEC%"=="main" (
  %SW_LOG_INFO%
  %SW_LOG_WARNING% --message="Readdle SDK is based on main branch. Compatibility with 5.3 is not guaranteed."
)
%SW_LOG_INFO%

if "%SW_INTERACTIVE%"=="NO" goto sw_save_config

:sw_ask_save
set SW_SAVE_CONFIG=Y
set /p SW_SAVE_CONFIG="Do you want to save this configuration? (%SW_SAVE_CONFIG%): "
call :sw_normalize_bool_input SW_SAVE_CONFIG
call :sw_validate_bool_input SW_SAVE_CONFIG
if errorlevel 1 goto sw_ask_save

if "%SW_SAVE_CONFIG%"=="Y" goto sw_save_config
if "%SW_SAVE_CONFIG%"=="N" goto sw_wizard_start


:sw_save_config
echo set SW_SWIFT_BRANCH_SPEC=%SW_SWIFT_BRANCH_SPEC%>%SW_CONFIG_FILE%
echo set SW_SWIFT_SDK_SPEC=%SW_SWIFT_SDK_SPEC%>>%SW_CONFIG_FILE%
echo set SW_SOURCES_DIR=%SW_SOURCES_DIR%>>%SW_CONFIG_FILE%
echo set SW_BUILD_DIR=%SW_BUILD_DIR%>>%SW_CONFIG_FILE%
echo set SW_INSTALL_DIR=%SW_INSTALL_DIR%>>%SW_CONFIG_FILE%
echo set SW_ARTIFACTS_DIR=%SW_ARTIFACTS_DIR%>>%SW_CONFIG_FILE%
echo set SW_PYTHON_DIR=%SW_PYTHON_DIR%>>%SW_CONFIG_FILE%
echo.>>%SW_CONFIG_FILE%
echo set SW_CURL_VERSION=%SW_CURL_VERSION%>>%SW_CONFIG_FILE%
echo set SW_ICU_VERSION=%SW_ICU_VERSION%>>%SW_CONFIG_FILE%
echo set SW_XML2_VERSION=%SW_XML2_VERSION%>>%SW_CONFIG_FILE%
echo set SW_ZLIB_VERSION=%SW_ZLIB_VERSION%>>%SW_CONFIG_FILE%
echo set SW_SQLITE_VERSION=%SW_SQLITE_VERSION%>>%SW_CONFIG_FILE%
echo set SW_SQLITE_RELEASE=%SW_SQLITE_RELEASE%>>%SW_CONFIG_FILE%
echo set SW_GIT_TAG=%SW_GIT_TAG%>>%SW_CONFIG_FILE%
echo.>>%SW_CONFIG_FILE%
echo set SW_OBJC_PATCH_ENABLED=%SW_OBJC_PATCH_ENABLED%>>%SW_CONFIG_FILE%
echo set SW_STDLIB_PATCH_ENABLED=%SW_STDLIB_PATCH_ENABLED%>>%SW_CONFIG_FILE%
echo.>>%SW_CONFIG_FILE%
echo set SW_SKIP_ICU=%SW_SKIP_ICU%>>%SW_CONFIG_FILE%
echo set SW_SKIP_TOOLCHAIN=%SW_SKIP_TOOLCHAIN%>>%SW_CONFIG_FILE%
echo set SW_SKIP_TOOLCHAIN_SWIFT_TEST=%SW_SKIP_TOOLCHAIN_SWIFT_TEST%>>%SW_CONFIG_FILE%
echo set SW_SKIP_ZLIB=%SW_SKIP_ZLIB%>>%SW_CONFIG_FILE%
echo set SW_SKIP_XML2=%SW_SKIP_XML2%>>%SW_CONFIG_FILE%
echo set SW_SKIP_CURL=%SW_SKIP_CURL%>>%SW_CONFIG_FILE%
echo set SW_SKIP_SDK=%SW_SKIP_SDK%>>%SW_CONFIG_FILE%
echo set SW_SKIP_SDK_CHECKOUT=%SW_SKIP_SDK_CHECKOUT%>>%SW_CONFIG_FILE%
echo set SW_SKIP_SDK_STDLIB=%SW_SKIP_SDK_STDLIB%>>%SW_CONFIG_FILE%
echo set SW_SKIP_SDK_DISPATCH=%SW_SKIP_SDK_DISPATCH%>>%SW_CONFIG_FILE%
echo set SW_SKIP_SDK_FOUNDATION=%SW_SKIP_SDK_FOUNDATION%>>%SW_CONFIG_FILE%
echo set SW_SKIP_SDK_XCTEST=%SW_SKIP_SDK_XCTEST%>>%SW_CONFIG_FILE%
echo set SW_SKIP_SDK_DISPATCH_TEST=%SW_SKIP_SDK_DISPATCH_TEST%>>%SW_CONFIG_FILE%
echo set SW_SKIP_SDK_FOUNDATION_TEST=%SW_SKIP_SDK_FOUNDATION_TEST%>>%SW_CONFIG_FILE%
echo set SW_SKIP_SQLITE=%SW_SKIP_SQLITE%>>%SW_CONFIG_FILE%
echo set SW_SKIP_DEVTOOLS=%SW_SKIP_DEVTOOLS%>>%SW_CONFIG_FILE%

%SW_LOG_INFO% --message="Configuration saved. Run build.cmd --config %SW_CONFIG_FILE%."

goto :eof
endlocal



rem ###########################################################################
:sw_parse_arguments <arguments...>
:sw_parse_arguments_start
set CURRENT_ARG=%~1

if "%NEXT_ARG%"=="SW_INTERACTIVE"                       goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_SWIFT_BRANCH_SPEC"                 goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_SWIFT_SDK_SPEC"                    goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_SOURCES_DIR"                       goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_BUILD_DIR"                         goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_INSTALL_DIR"                       goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_ARTIFACTS_DIR"                     goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_PYTHON_DIR"                        goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_GIT_TAG"                           goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_CONFIG_FILE"                       goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_OBJC_PATCH_ENABLED"                goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_STDLIB_PATCH_ENABLED"              goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_SKIP_ICU"                          goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_SKIP_TOOLCHAIN"                    goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_SKIP_TOOLCHAIN_SWIFT_TEST"         goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_SKIP_ZLIB"                         goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_SKIP_XML2"                         goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_SKIP_CURL"                         goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_SKIP_SDK"                          goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_SKIP_SDK_CHECKOUT"                 goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_SKIP_SDK_STDLIB"                   goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_SKIP_SDK_DISPATCH"                 goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_SKIP_SDK_FOUNDATION"               goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_SKIP_SDK_XCTEST"                   goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_SKIP_SDK_DISPATCH_TEST"            goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_SKIP_SDK_FOUNDATION_TEST"          goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_SKIP_DEVTOOLS"                     goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_SKIP_SQLITE"                       goto sw_parse_arguments_accept

if not defined CURRENT_ARG goto sw_parse_argumens_end

if "%CURRENT_ARG%"=="--interactive" (                      set NEXT_ARG=SW_INTERACTIVE
) else if "%CURRENT_ARG%"=="--branch" (                    set NEXT_ARG=SW_SWIFT_BRANCH_SPEC
) else if "%CURRENT_ARG%"=="--sdk" (                       set NEXT_ARG=SW_SWIFT_SDK_SPEC
) else if "%CURRENT_ARG%"=="--sources-dir" (               set NEXT_ARG=SW_SOURCES_DIR
) else if "%CURRENT_ARG%"=="--build-dir" (                 set NEXT_ARG=SW_BUILD_DIR
) else if "%CURRENT_ARG%"=="--install-dir" (               set NEXT_ARG=SW_INSTALL_DIR
) else if "%CURRENT_ARG%"=="--artifacts-dir" (             set NEXT_ARG=SW_ARTIFACTS_DIR
) else if "%CURRENT_ARG%"=="--python-dir" (                set NEXT_ARG=SW_PYTHON_DIR
) else if "%CURRENT_ARG%"=="--git-tag" (                   set NEXT_ARG=SW_GIT_TAG
) else if "%CURRENT_ARG%"=="--config" (                    set NEXT_ARG=SW_CONFIG_FILE
) else if "%CURRENT_ARG%"=="--enable-no-objc-patch" (      set NEXT_ARG=SW_OBJC_PATCH_ENABLED
) else if "%CURRENT_ARG%"=="--enable-print-patch" (        set NEXT_ARG=SW_STDLIB_PATCH_ENABLED
) else if "%CURRENT_ARG%"=="--skip-icu" (                  set NEXT_ARG=SW_SKIP_ICU
) else if "%CURRENT_ARG%"=="--skip-toolchain" (            set NEXT_ARG=SW_SKIP_TOOLCHAIN
) else if "%CURRENT_ARG%"=="--skip-toolchain-swift-test" ( set NEXT_ARG=SW_SKIP_TOOLCHAIN_SWIFT_TEST
) else if "%CURRENT_ARG%"=="--skip-zlib" (                 set NEXT_ARG=SW_SKIP_ZLIB
) else if "%CURRENT_ARG%"=="--skip-xml2" (                 set NEXT_ARG=SW_SKIP_XML2
) else if "%CURRENT_ARG%"=="--skip-curl" (                 set NEXT_ARG=SW_SKIP_CURL
) else if "%CURRENT_ARG%"=="--skip-sdk" (                  set NEXT_ARG=SW_SKIP_SDK
) else if "%CURRENT_ARG%"=="--skip-sdk-checkout" (         set NEXT_ARG=SW_SKIP_SDK_CHECKOUT
) else if "%CURRENT_ARG%"=="--skip-sdk-stdlib" (           set NEXT_ARG=SW_SKIP_SDK_STDLIB
) else if "%CURRENT_ARG%"=="--skip-sdk-dispatch" (         set NEXT_ARG=SW_SKIP_SDK_DISPATCH
) else if "%CURRENT_ARG%"=="--skip-sdk-foundation" (       set NEXT_ARG=SW_SKIP_SDK_FOUNDATION
) else if "%CURRENT_ARG%"=="--skip-sdk-xctest" (           set NEXT_ARG=SW_SKIP_SDK_XCTEST
) else if "%CURRENT_ARG%"=="--skip-sdk-dispatch-test" (    set NEXT_ARG=SW_SKIP_SDK_DISPATCH_TEST
) else if "%CURRENT_ARG%"=="--skip-sdk-foundation-test" (  set NEXT_ARG=SW_SKIP_SDK_FOUNDATION_TEST
) else if "%CURRENT_ARG%"=="--skip-sqlite" (               set NEXT_ARG=SW_SKIP_SQLITE
) else if "%CURRENT_ARG%"=="--skip-devtools" (             set NEXT_ARG=SW_SKIP_DEVTOOLS
) else if "%CURRENT_ARG%"=="--help" (                      goto help
) else (
  %SW_LOG_ERROR% --message="Unknown argument: %CURRENT_ARG%"
  exit /b 1
)
goto sw_parse_arguments_next

:sw_parse_arguments_accept
set "%NEXT_ARG%=%CURRENT_ARG%"
set NEXT_ARG=

:sw_parse_arguments_next
shift
goto sw_parse_arguments_start
:sw_parse_argumens_end

exit /b



rem ###########################################################################
:sw_validate_parameters
setlocal enabledelayedexpansion
for %%G in (SW_INTERACTIVE^
 SW_SWIFT_BRANCH_SPEC^
 SW_SWIFT_SDK_SPEC^
 SW_SOURCES_DIR^
 SW_BUILD_DIR^
 SW_INSTALL_DIR^
 SW_ARTIFACTS_DIR^
 SW_PYTHON_DIR^
 SW_CONFIG_FILE^
 SW_OBJC_PATCH_ENABLED^
 SW_STDLIB_PATCH_ENABLED^
 SW_SKIP_ICU^
 SW_SKIP_TOOLCHAIN^
 SW_SKIP_TOOLCHAIN_SWIFT_TEST^
 SW_SKIP_ZLIB^
 SW_SKIP_XML2^
 SW_SKIP_CURL^
 SW_SKIP_SDK^
 SW_SKIP_SDK_CHECKOUT^
 SW_SKIP_SDK_STDLIB^
 SW_SKIP_SDK_DISPATCH^
 SW_SKIP_SDK_FOUNDATION^
 SW_SKIP_SDK_XCTEST^
 SW_SKIP_SDK_DISPATCH_TEST^
 SW_SKIP_SDK_FOUNDATION_TEST^
 SW_SKIP_SQLITE^
 SW_SKIP_DEVTOOLS) do (
  call :sw_validate_parameter %%G
  if errorlevel 1 goto sw_validate_parameters_fail
)
endlocal
exit /b

:sw_validate_parameters_fail
endlocal
exit /b 1


rem ###########################################################################
:sw_validate_parameter <parameter>
setlocal enabledelayedexpansion

set PARAMETER=%1
set VALUE=!%PARAMETER%!

if "%PARAMETER%"=="SW_INTERACTIVE" (
  if /i not "%VALUE%"=="YES" if /i not "%VALUE%"=="NO" goto sw_validate_parameter_fail
) else if "%PARAMETER%"=="SW_SWIFT_BRANCH_SPEC" (
  if /i not "%VALUE%"=="main" if /i not "%VALUE%"=="5.5" if /i not "%VALUE%"=="5.4" if /i not "%VALUE%"=="5.3" goto sw_validate_parameter_fail
) else if "%PARAMETER%"=="SW_SWIFT_SDK_SPEC" (
  if /i not "%VALUE%"=="apple" if /i not "%VALUE%"=="readdle" goto sw_validate_parameter_fail
) else if "%PARAMETER%"=="SW_SOURCES_DIR" (
  if "%VALUE%"=="" goto sw_validate_parameter_fail
) else if "%PARAMETER%"=="SW_BUILD_DIR" (
  if "%VALUE%"=="" goto sw_validate_parameter_fail
) else if "%PARAMETER%"=="SW_INSTALL_DIR" (
  if "%VALUE%"=="" goto sw_validate_parameter_fail
) else if "%PARAMETER%"=="SW_PYTHON_DIR" (
  if "%VALUE%"=="" goto sw_validate_parameter_fail
) else if "%PARAMETER%"=="SW_CONFIG_FILE" (
  if "%VALUE%"=="" goto sw_validate_parameter_fail
) else if "%PARAMETER%"=="SW_OBJC_PATCH_ENABLED" (
  goto sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_STDLIB_PATCH_ENABLED" (
  goto sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_SKIP_ICU" (
  goto sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_SKIP_TOOLCHAIN" (
  goto sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_SKIP_TOOLCHAIN_SWIFT_TEST" (
  goto sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_SKIP_ZLIB" (
  goto sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_SKIP_XML2" (
  goto sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_SKIP_CURL" (
  goto sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_SKIP_SDK" (
  goto sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_SKIP_SDK_CHECKOUT" (
  goto sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_SKIP_SDK_STDLIB" (
  goto sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_SKIP_SDK_DISPATCH" (
  goto sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_SKIP_SDK_FOUNDATION" (
  goto sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_SKIP_SDK_XCTEST" (
  goto sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_SKIP_SDK_DISPATCH_TEST" (
  goto sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_SKIP_SDK_FOUNDATION_TEST" (
  goto sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_SKIP_SQLITE" (
  goto sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_SKIP_DEVTOOLS" (
  goto sw_validate_parameter_bool
)
endlocal
exit /b

:sw_validate_parameter_bool
call :sw_validate_bool_value %VALUE%
if errorlevel 1 goto sw_validate_parameter_fail
endlocal
exit /b

:sw_validate_parameter_fail
%SW_LOG_ERROR% --message="%PARAMETER% - Invalid value: %VALUE%"
endlocal
exit /b 1



rem ###########################################################################
:sw_normalize_parameters_for_wizard
for %%G in (SW_OBJC_PATCH_ENABLED^
 SW_STDLIB_PATCH_ENABLED^
 SW_SKIP_ICU^
 SW_SKIP_TOOLCHAIN^
 SW_SKIP_TOOLCHAIN_SWIFT_TEST^
 SW_SKIP_ZLIB^
 SW_SKIP_XML2^
 SW_SKIP_CURL^
 SW_SKIP_SDK^
 SW_SKIP_SDK_CHECKOUT^
 SW_SKIP_SDK_STDLIB^
 SW_SKIP_SDK_DISPATCH^
 SW_SKIP_SDK_FOUNDATION^
 SW_SKIP_SDK_XCTEST^
 SW_SKIP_SDK_DISPATCH_TEST^
 SW_SKIP_SDK_FOUNDATION_TEST^
 SW_SKIP_SQLITE^
 SW_SKIP_DEVTOOLS) do (
  call :sw_normalize_bool_parameter_for_wizard %%G
)
exit /b



rem ###########################################################################
:sw_normalize_parameters_for_saving

for %%G in (SW_OBJC_PATCH_ENABLED^
 SW_STDLIB_PATCH_ENABLED^
 SW_SKIP_ICU^
 SW_SKIP_TOOLCHAIN^
 SW_SKIP_TOOLCHAIN_SWIFT_TEST^
 SW_SKIP_ZLIB^
 SW_SKIP_XML2^
 SW_SKIP_CURL^
 SW_SKIP_SDK^
 SW_SKIP_SDK_CHECKOUT^
 SW_SKIP_SDK_STDLIB^
 SW_SKIP_SDK_DISPATCH^
 SW_SKIP_SDK_FOUNDATION^
 SW_SKIP_SDK_XCTEST^
 SW_SKIP_SDK_DISPATCH_TEST^
 SW_SKIP_SDK_FOUNDATION_TEST^
 SW_SKIP_SQLITE^
 SW_SKIP_DEVTOOLS) do (
  call :sw_normalize_bool_parameter_for_saving %%G
)
exit /b



rem ###########################################################################
:sw_normalize_bool_parameter_for_wizard <parameter>
setlocal enabledelayedexpansion

set PARAMETER=%1
set VALUE=!%PARAMETER%!

if "%VALUE%"=="YES" set VALUE=Y
if "%VALUE%"=="NO" set VALUE=N
if "%VALUE%"=="" set VALUE=N

(
  endlocal
  set %1=%VALUE%
  exit /b
)



rem ###########################################################################
:sw_normalize_bool_parameter_for_saving <parameter>
setlocal enabledelayedexpansion

set PARAMETER=%1
set VALUE=!%PARAMETER%!

if "%VALUE%"=="Y" set VALUE=YES
if "%VALUE%"=="N" set VALUE=NO
if "%VALUE%"=="" set VALUE=NO

(
  endlocal
  set %1=%VALUE%
  exit /b
)



rem ###########################################################################
:sw_normalize_bool_input <parameter>
setlocal enabledelayedexpansion

set PARAMETER=%1
set VALUE=!%PARAMETER%!

if /i "%VALUE%"=="Y" set VALUE=Y
if /i "%VALUE%"=="N" set VALUE=N

(
  endlocal
  set %1=%VALUE%
  exit /b
)



rem ###########################################################################
:sw_validate_bool_input <parameter>
setlocal enabledelayedexpansion

set PARAMETER=%1
set VALUE=!%PARAMETER%!

if not "%VALUE%"=="Y" if not "%VALUE%"=="N" exit /b 1

endlocal
exit /b



rem ###########################################################################
:sw_validate_bool_value <value>
setlocal enabledelayedexpansion

if not "%1"=="YES" if not "%1"=="NO" exit /b 1

endlocal
exit /b



rem ###########################################################################
:sw_ask_branch
set SW_ORIGINAL_VALUE=%SW_BRANCH_NUM%

:sw_ask_branch_input
echo Available branches:
echo.  1. main
echo.  2. 5.5
echo.  3. 5.4
echo.  4. 5.3

set /p SW_BRANCH_NUM="Enter branch number to build (%SW_BRANCH_NUM%): "

if "%SW_BRANCH_NUM%"=="1" (
  set SW_SWIFT_BRANCH_SPEC=main
) else if "%SW_BRANCH_NUM%"=="2" (
  set SW_SWIFT_BRANCH_SPEC=5.5
) else if "%SW_BRANCH_NUM%"=="3" (
  set SW_SWIFT_BRANCH_SPEC=5.4
) else if "%SW_BRANCH_NUM%"=="4" (
  set SW_SWIFT_BRANCH_SPEC=5.3
) else (
  set SW_BRANCH_NUM=%SW_ORIGINAL_VALUE%
  goto sw_ask_branch_input
)

exit /b



rem ###########################################################################
:sw_ask_sdk_spec
set SW_ORIGINAL_VALUE=%SW_SWIFT_SDK_SPEC_NUM%

:sw_ask_sdk_spec_input
echo Available SDK specs:
echo.  1. Apple
echo.  2. Readdle

set /p SW_SWIFT_SDK_SPEC_NUM="Enter SDK spec number (%SW_SWIFT_SDK_SPEC_NUM%): "

if "%SW_SWIFT_SDK_SPEC_NUM%"=="1" (
  set SW_SWIFT_SDK_SPEC=apple
) else if "%SW_SWIFT_SDK_SPEC_NUM%"=="2" (
  set SW_SWIFT_SDK_SPEC=readdle
) else (
  set SW_SWIFT_SDK_SPEC_NUM=%SW_ORIGINAL_VALUE%
  goto sw_ask_sdk_spec_input
)

exit /b



rem ###########################################################################
:sw_ask_git_tag

set /p SW_GIT_TAG="Enter Git tag (e.g. release or snapshot tag) (%SW_GIT_TAG%): "

exit /b



rem ###########################################################################
:sw_ask_directories

set /p SW_SOURCES_DIR="Enter directory for source files (%SW_SOURCES_DIR%): "
set /p SW_BUILD_DIR="Enter directory for build output (%SW_BUILD_DIR%): "
set /p SW_INSTALL_DIR="Enter directory to install into (%SW_INSTALL_DIR%): "
set /p SW_PYTHON_DIR="Enter Python directory (%SW_PYTHON_DIR%): "

exit /b



rem ###########################################################################
:sw_ask_swift_patch
set SW_ORIGINAL_VALUE=%SW_OBJC_PATCH_ENABLED%

:sw_ask_swift_patch_input
set /p SW_OBJC_PATCH_ENABLED="Apply @objc patch (%SW_OBJC_PATCH_ENABLED%)?: "
call :sw_normalize_bool_input SW_OBJC_PATCH_ENABLED
call :sw_validate_bool_input SW_OBJC_PATCH_ENABLED
if errorlevel 1 (
  set SW_OBJC_PATCH_ENABLED=%SW_ORIGINAL_VALUE%
  goto sw_ask_swift_patch_input
)

exit /b



rem ###########################################################################
:sw_ask_stdlib_patch
set SW_ORIGINAL_VALUE=%SW_STDLIB_PATCH_ENABLED%

:sw_ask_stdlib_patch_input
set /p SW_STDLIB_PATCH_ENABLED="Apply print flush patch (%SW_STDLIB_PATCH_ENABLED%)?: "
call :sw_normalize_bool_input SW_STDLIB_PATCH_ENABLED
call :sw_validate_bool_input SW_STDLIB_PATCH_ENABLED
if errorlevel 1 (
  set SW_STDLIB_PATCH_ENABLED=%SW_ORIGINAL_VALUE%
  goto sw_ask_stdlib_patch_input
)

exit /b



rem ###########################################################################
:sw_ask_fine_tune
set SW_ORIGINAL_VALUE=%SW_DEFAULT_JOBS_CONFIGURATION%

:sw_ask_fine_tune_input
set /p SW_DEFAULT_JOBS_CONFIGURATION="Use default jobs/steps configuration (%SW_DEFAULT_JOBS_CONFIGURATION%)?: "
call :sw_normalize_bool_input SW_DEFAULT_JOBS_CONFIGURATION
call :sw_validate_bool_input SW_DEFAULT_JOBS_CONFIGURATION
if errorlevel 1 (
  set SW_DEFAULT_JOBS_CONFIGURATION=%SW_ORIGINAL_VALUE%
  goto sw_ask_fine_tune_input
)

if "%SW_DEFAULT_JOBS_CONFIGURATION%"=="Y" exit /b

call :sw_ask_icu
call :sw_ask_toolchain
call :sw_ask_zlib
call :sw_ask_xml2
call :sw_ask_curl
call :sw_ask_sdk
call :sw_ask_sqlite
call :sw_ask_devtools

exit /b



rem ###########################################################################
:sw_ask_icu
set SW_ORIGINAL_VALUE=%SW_SKIP_ICU%

:sw_ask_icu_input
set /p SW_SKIP_ICU="Skip ICU (%SW_SKIP_ICU%)?: "
call :sw_normalize_bool_input SW_SKIP_ICU
call :sw_validate_bool_input SW_SKIP_ICU
if errorlevel 1 (
  set SW_SKIP_ICU=%SW_ORIGINAL_VALUE%
  goto sw_ask_icu_input
)

exit /b



rem ###########################################################################
:sw_ask_toolchain
set SW_ORIGINAL_VALUE=%SW_SKIP_TOOLCHAIN%

:sw_ask_toolchain_input
set /p SW_SKIP_TOOLCHAIN="Skip Toolchain (%SW_SKIP_TOOLCHAIN%)?: "
call :sw_normalize_bool_input SW_SKIP_TOOLCHAIN
call :sw_validate_bool_input SW_SKIP_TOOLCHAIN
if errorlevel 1 (
  set SW_SKIP_TOOLCHAIN=%SW_ORIGINAL_VALUE%
  goto sw_ask_toolchain_input
)

if "%SW_SKIP_TOOLCHAIN%"=="Y" exit /b

set SW_ORIGINAL_VALUE=%SW_DEFAULT_TOOLCHAIN_CONFIGURATION%

:sw_ask_toolchain_fine_tune_input
set /p SW_DEFAULT_TOOLCHAIN_CONFIGURATION="Use default Toolchain steps configuration (%SW_DEFAULT_TOOLCHAIN_CONFIGURATION%)?: "
call :sw_normalize_bool_input SW_DEFAULT_TOOLCHAIN_CONFIGURATION
call :sw_validate_bool_input SW_DEFAULT_TOOLCHAIN_CONFIGURATION
if errorlevel 1 (
  set SW_DEFAULT_TOOLCHAIN_CONFIGURATION=%SW_ORIGINAL_VALUE%
  goto sw_ask_toolchain_fine_tune_input
)

if "%SW_DEFAULT_TOOLCHAIN_CONFIGURATION%"=="Y" exit /b

call :sw_ask_swift_test

exit /b



rem ###########################################################################
:sw_ask_zlib
set SW_ORIGINAL_VALUE=%SW_SKIP_ZLIB%

:sw_ask_zlib_input
set /p SW_SKIP_ZLIB="Skip zlib (%SW_SKIP_ZLIB%)?: "
call :sw_normalize_bool_input SW_SKIP_ZLIB
call :sw_validate_bool_input SW_SKIP_ZLIB
if errorlevel 1 (
  set SW_SKIP_ZLIB=%SW_ORIGINAL_VALUE%
  goto sw_ask_zlib_input
)

exit /b



rem ###########################################################################
:sw_ask_xml2
set SW_ORIGINAL_VALUE=%SW_SKIP_XML2%

:sw_ask_xml2_input
set /p SW_SKIP_XML2="Skip libxml2 (%SW_SKIP_XML2%)?: "
call :sw_normalize_bool_input SW_SKIP_XML2
call :sw_validate_bool_input SW_SKIP_XML2
if errorlevel 1 (
  set SW_SKIP_XML2=%SW_ORIGINAL_VALUE%
  goto sw_ask_xml2_input
)

exit /b



rem ###########################################################################
:sw_ask_curl
set SW_ORIGINAL_VALUE=%SW_SKIP_CURL%

:sw_ask_curl_input
set /p SW_SKIP_CURL="Skip curl (%SW_SKIP_CURL%)?: "
call :sw_normalize_bool_input SW_SKIP_CURL
call :sw_validate_bool_input SW_SKIP_CURL
if errorlevel 1 (
  set SW_SKIP_CURL=%SW_ORIGINAL_VALUE%
  goto sw_ask_curl_input
)

exit /b



rem ###########################################################################
:sw_ask_sdk
set SW_ORIGINAL_VALUE=%SW_SKIP_SDK%

:sw_ask_sdk_input
set /p SW_SKIP_SDK="Skip SDK (%SW_SKIP_SDK%)?: "
call :sw_normalize_bool_input SW_SKIP_SDK
call :sw_validate_bool_input SW_SKIP_SDK
if errorlevel 1 (
  set SW_SKIP_SDK=%SW_ORIGINAL_VALUE%
  goto sw_ask_sdk_input
)

if "%SW_SKIP_SDK%"=="Y" exit /b

set SW_ORIGINAL_VALUE=%SW_DEFAULT_SDK_CONFIGURATION%

:sw_ask_sdk_fine_tune_input
set /p SW_DEFAULT_SDK_CONFIGURATION="Use default SDK steps configuration (%SW_DEFAULT_SDK_CONFIGURATION%)?: "
call :sw_normalize_bool_input SW_DEFAULT_SDK_CONFIGURATION
call :sw_validate_bool_input SW_DEFAULT_SDK_CONFIGURATION
if errorlevel 1 (
  set SW_DEFAULT_SDK_CONFIGURATION=%SW_ORIGINAL_VALUE%
  goto sw_ask_sdk_fine_tune_input
)

if "%SW_DEFAULT_SDK_CONFIGURATION%"=="Y" exit /b

call :sw_ask_sdk_checkout
call :sw_ask_sdk_stdlib
call :sw_ask_sdk_dispatch
call :sw_ask_sdk_foundation
call :sw_ask_sdk_xctest
call :sw_ask_sdk_dispatch_test
call :sw_ask_sdk_foundation_test

exit /b



rem ###########################################################################
:sw_ask_sqlite
set SW_ORIGINAL_VALUE=%SW_SKIP_SQLITE%

:sw_ask_sqlite_input
set /p SW_SKIP_SQLITE="Skip SQLite (%SW_SKIP_SQLITE%)?: "
call :sw_normalize_bool_input SW_SKIP_SQLITE
call :sw_validate_bool_input SW_SKIP_SQLITE
if errorlevel 1 (
  set SW_SKIP_SQLITE=%SW_ORIGINAL_VALUE%
  goto sw_ask_sqlite_input
)

exit /b



rem ###########################################################################
:sw_ask_devtools
set SW_ORIGINAL_VALUE=%SW_SKIP_DEVTOOLS%

:sw_ask_devtools_input
set /p SW_SKIP_DEVTOOLS="Skip DevTools (%SW_SKIP_DEVTOOLS%)?: "
call :sw_normalize_bool_input SW_SKIP_DEVTOOLS
call :sw_validate_bool_input SW_SKIP_DEVTOOLS
if errorlevel 1 (
  set SW_SKIP_DEVTOOLS=%SW_ORIGINAL_VALUE%
  goto sw_ask_devtools_input
)

if "%SW_SKIP_DEVTOOLS%"=="Y" exit /b

set SW_ORIGINAL_VALUE=%SW_DEFAULT_DEVTOOLS_CONFIGURATION%

:sw_ask_devtools_fine_tune_input
set /p SW_DEFAULT_DEVTOOLS_CONFIGURATION="Use default DevTools steps configuration (%SW_DEFAULT_DEVTOOLS_CONFIGURATION%)?: "
call :sw_normalize_bool_input SW_DEFAULT_DEVTOOLS_CONFIGURATION
call :sw_validate_bool_input SW_DEFAULT_DEVTOOLS_CONFIGURATION
if errorlevel 1 (
  set SW_DEFAULT_DEVTOOLS_CONFIGURATION=%SW_ORIGINAL_VALUE%
  goto sw_ask_devtools_fine_tune_input
)

if "%SW_DEFAULT_DEVTOOLS_CONFIGURATION%"=="Y" exit /b

%SW_LOG_WARNING% --message="Not yet implemented"

exit /b



rem ###########################################################################
:sw_ask_swift_test
set SW_ORIGINAL_VALUE=%SW_SKIP_TOOLCHAIN_SWIFT_TEST%

:sw_ask_swift_test_input
set /p SW_SKIP_TOOLCHAIN_SWIFT_TEST="Skip Swift test (%SW_SKIP_TOOLCHAIN_SWIFT_TEST%)?: "
call :sw_normalize_bool_input SW_SKIP_TOOLCHAIN_SWIFT_TEST
call :sw_validate_bool_input SW_SKIP_TOOLCHAIN_SWIFT_TEST
if errorlevel 1 (
  set SW_SKIP_TOOLCHAIN_SWIFT_TEST=%SW_ORIGINAL_VALUE%
  goto sw_ask_swift_test_input
)

exit /b



rem ###########################################################################
:sw_ask_sdk_checkout
set SW_ORIGINAL_VALUE=%SW_SKIP_SDK_CHECKOUT%

:sw_ask_sdk_checkout_input
set /p SW_SKIP_SDK_CHECKOUT="Skip SDK chekout (%SW_SKIP_SDK_CHECKOUT%)?: "
call :sw_normalize_bool_input SW_SKIP_SDK_CHECKOUT
call :sw_validate_bool_input SW_SKIP_SDK_CHECKOUT
if errorlevel 1 (
  set SW_SKIP_SDK_CHECKOUT=%SW_ORIGINAL_VALUE%
  goto sw_ask_sdk_checkout_input
)

exit /b



rem ###########################################################################
:sw_ask_sdk_stdlib
set SW_ORIGINAL_VALUE=%SW_SKIP_SDK_STDLIB%

:sw_ask_sdk_stdlib_input
set /p SW_SKIP_SDK_STDLIB="Skip StdLib (%SW_SKIP_SDK_STDLIB%)?: "
call :sw_normalize_bool_input SW_SKIP_SDK_STDLIB
call :sw_validate_bool_input SW_SKIP_SDK_STDLIB
if errorlevel 1 (
  set SW_SKIP_SDK_STDLIB=%SW_ORIGINAL_VALUE%
  goto sw_ask_sdk_stdlib_input
)

exit /b



rem ###########################################################################
:sw_ask_sdk_dispatch
set SW_ORIGINAL_VALUE=%SW_SKIP_SDK_DISPATCH%

:sw_ask_sdk_dispatch_input
set /p SW_SKIP_SDK_DISPATCH="Skip Dispatch (%SW_SKIP_SDK_DISPATCH%)?: "
call :sw_normalize_bool_input SW_SKIP_SDK_DISPATCH
call :sw_validate_bool_input SW_SKIP_SDK_DISPATCH
if errorlevel 1 (
  set SW_SKIP_SDK_DISPATCH=%SW_ORIGINAL_VALUE%
  goto sw_ask_sdk_dispatch_input
)

exit /b



rem ###########################################################################
:sw_ask_sdk_foundation
set SW_ORIGINAL_VALUE=%SW_SKIP_SDK_FOUNDATION%

:sw_ask_sdk_foundation_input
set /p SW_SKIP_SDK_FOUNDATION="Skip Foundation (%SW_SKIP_SDK_FOUNDATION%)?: "
call :sw_normalize_bool_input SW_SKIP_SDK_FOUNDATION
call :sw_validate_bool_input SW_SKIP_SDK_FOUNDATION
if errorlevel 1 (
  set SW_SKIP_SDK_FOUNDATION=%SW_ORIGINAL_VALUE%
  goto sw_ask_sdk_foundation_input
)

exit /b



rem ###########################################################################
:sw_ask_sdk_xctest
set SW_ORIGINAL_VALUE=%SW_SKIP_SDK_XCTEST%

:sw_ask_sdk_xctest_input
set /p SW_SKIP_SDK_XCTEST="Skip XCTest (%SW_SKIP_SDK_XCTEST%)?: "
call :sw_normalize_bool_input SW_SKIP_SDK_XCTEST
call :sw_validate_bool_input SW_SKIP_SDK_XCTEST
if errorlevel 1 (
  set SW_SKIP_SDK_XCTEST=%SW_ORIGINAL_VALUE%
  goto sw_ask_sdk_xctest_input
)

exit /b



rem ###########################################################################
:sw_ask_sdk_dispatch_test
set SW_ORIGINAL_VALUE=%SW_SKIP_SDK_DISPATCH_TEST%

:sw_ask_sdk_dispatch_test_input
set /p SW_SKIP_SDK_DISPATCH_TEST="Skip Dispatch test (%SW_SKIP_SDK_DISPATCH_TEST%)?: "
call :sw_normalize_bool_input SW_SKIP_SDK_DISPATCH_TEST
call :sw_validate_bool_input SW_SKIP_SDK_DISPATCH_TEST
if errorlevel 1 (
  set SW_SKIP_SDK_DISPATCH_TEST=%SW_ORIGINAL_VALUE%
  goto sw_ask_sdk_dispatch_test_input
)

exit /b



rem ###########################################################################
:sw_ask_sdk_foundation_test
set SW_ORIGINAL_VALUE=%SW_SKIP_SDK_FOUNDATION_TEST%

:sw_ask_sdk_foundation_test_input
set /p SW_SKIP_SDK_FOUNDATION_TEST="Skip Foundation test (%SW_SKIP_SDK_FOUNDATION_TEST%)?: "
call :sw_normalize_bool_input SW_SKIP_SDK_FOUNDATION_TEST
call :sw_validate_bool_input SW_SKIP_SDK_FOUNDATION_TEST
if errorlevel 1 (
  set SW_SKIP_SDK_FOUNDATION_TEST=%SW_ORIGINAL_VALUE%
  goto sw_ask_sdk_foundation_test_input
)

exit /b



rem ###########################################################################
:sw_ask_config_file

:sw_ask_config_file_input
set /p SW_CONFIG_FILE="Enter configuration file name to save (%SW_CONFIG_FILE%): "
if "%SW_CONFIG_FILE%"=="" (
  goto sw_ask_config_file_input
)

exit /b

endlocal
