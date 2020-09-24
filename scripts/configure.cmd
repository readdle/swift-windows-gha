@echo off

setlocal enabledelayedexpansion

call "%~f0\..\tools\log.cmd" > nul

set SW_LOG_INFO=%SW_LOG_INFO% --scope config
set SW_LOG_ERROR=%SW_LOG_ERROR% --scope config

set SW_INTERACTIVE=YES

set SW_SWIFT_BRANCH_SPEC=master
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
set SW_CONFIG_FILE=%CD%\config.cmd

call :sw_parse_arguments %* && call :sw_validate_parameters
if errorlevel 1 goto :eof

if "%SW_INTERACTIVE%"=="NO" (
  %SW_LOG_INFO% --message="Non-interactive mode"
  goto configure
) else (
  %SW_LOG_INFO% --message="Interactive mode"
)

if /i "%SW_SWIFT_BRANCH_SPEC%"=="master" (
  set SW_BRANCH_NUM=1
) else if /i "%SW_SWIFT_BRANCH_SPEC%"=="5.3" (
  set SW_BRANCH_NUM=2
)

if /i "%SW_SWIFT_SDK_SPEC%"=="apple" (
  set SW_SWIFT_SDK_SPEC_NUM=1
) else if /i "%SW_SWIFT_SDK_SPEC%"=="readdle" (
  set SW_SWIFT_SDK_SPEC_NUM=2
)

:sw_wizard_start

call :sw_normalize_parameters_for_wizard

call :sw_ask_branch
call :sw_ask_sdk_spec
call :sw_ask_directories
call :sw_ask_swift_patch
call :sw_ask_stdlib_patch
call :sw_ask_fine_tune
call :sw_ask_config_file

:configure
set SW_ICU_VERSION=67
set SW_CURL_VERSION=development
set SW_XML2_VERSION=development
set SW_ZLIB_VERSION=1.2.11
set SW_ARTIFACTS_DIR=%SW_INSTALL_DIR%

call :sw_normalize_parameters_for_saving

%SW_LOG_INFO%
%SW_LOG_INFO% --prefix="Swift branch spec:       " --message="%SW_SWIFT_BRANCH_SPEC%"
%SW_LOG_INFO% --prefix="Swift SDK spec:          " --message="%SW_SWIFT_SDK_SPEC%"
%SW_LOG_INFO% --prefix="Source files directory:  " --message="%SW_SOURCES_DIR%"
%SW_LOG_INFO% --prefix="Build output directory:  " --message="%SW_BUILD_DIR%"
%SW_LOG_INFO% --prefix="Install directory:       " --message="%SW_INSTALL_DIR%"
%SW_LOG_INFO% --prefix="Artifacts directory:     " --message="%SW_ARTIFACTS_DIR%"
%SW_LOG_INFO%
%SW_LOG_INFO% --prefix="CURL version:            " --message="%SW_CURL_VERSION%"
%SW_LOG_INFO% --prefix="ICU version:             " --message="%SW_ICU_VERSION%"
%SW_LOG_INFO% --prefix="XML2 version:            " --message="%SW_XML2_VERSION%"
%SW_LOG_INFO% --prefix="ZLIB version:            " --message="%SW_ZLIB_VERSION%"
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
echo.>>%SW_CONFIG_FILE%
echo set SW_CURL_VERSION=%SW_CURL_VERSION%>>%SW_CONFIG_FILE%
echo set SW_ICU_VERSION=%SW_ICU_VERSION%>>%SW_CONFIG_FILE%
echo set SW_XML2_VERSION=%SW_XML2_VERSION%>>%SW_CONFIG_FILE%
echo set SW_ZLIB_VERSION=%SW_ZLIB_VERSION%>>%SW_CONFIG_FILE%
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

if not defined CURRENT_ARG goto sw_parse_argumens_end

if "%CURRENT_ARG%"=="--interactive" (                      set NEXT_ARG=SW_INTERACTIVE
) else if "%CURRENT_ARG%"=="--branch" (                    set NEXT_ARG=SW_SWIFT_BRANCH_SPEC
) else if "%CURRENT_ARG%"=="--sdk" (                       set NEXT_ARG=SW_SWIFT_SDK_SPEC
) else if "%CURRENT_ARG%"=="--sources-dir" (               set NEXT_ARG=SW_SOURCES_DIR
) else if "%CURRENT_ARG%"=="--build-dir" (                 set NEXT_ARG=SW_BUILD_DIR
) else if "%CURRENT_ARG%"=="--install-dir" (               set NEXT_ARG=SW_INSTALL_DIR
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
) else if "%CURRENT_ARG%"=="--help" (                      goto help
) else (
  %SW_LOG_ERROR% --message="Unknown argument: %CURRENT_ARG%"
  exit /b 1
)
goto :sw_parse_arguments_next

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
 SW_SKIP_SDK_FOUNDATION_TEST) do (
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
  if /i not "%VALUE%"=="YES" if /i not "%VALUE%"=="NO" goto :sw_validate_parameter_fail
) else if "%PARAMETER%"=="SW_SWIFT_BRANCH_SPEC" (
  if /i not "%VALUE%"=="master" if /i not "%VALUE%"=="5.3" goto :sw_validate_parameter_fail
) else if "%PARAMETER%"=="SW_SWIFT_SDK_SPEC" (
  if /i not "%VALUE%"=="apple" if /i not "%VALUE%"=="readdle" goto :sw_validate_parameter_fail
) else if "%PARAMETER%"=="SW_SOURCES_DIR" (
  if "%VALUE%"=="" goto :sw_validate_parameter_fail
) else if "%PARAMETER%"=="SW_BUILD_DIR" (
  if "%VALUE%"=="" goto :sw_validate_parameter_fail
) else if "%PARAMETER%"=="SW_INSTALL_DIR" (
  if "%VALUE%"=="" goto :sw_validate_parameter_fail
) else if "%PARAMETER%"=="SW_CONFIG_FILE" (
  if "%VALUE%"=="" goto :sw_validate_parameter_fail
) else if "%PARAMETER%"=="SW_OBJC_PATCH_ENABLED" (
  goto :sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_STDLIB_PATCH_ENABLED" (
  goto :sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_SKIP_ICU" (
  goto :sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_SKIP_TOOLCHAIN" (
  goto :sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_SKIP_TOOLCHAIN_SWIFT_TEST" (
  goto :sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_SKIP_ZLIB" (
  goto :sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_SKIP_XML2" (
  goto :sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_SKIP_CURL" (
  goto :sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_SKIP_SDK" (
  goto :sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_SKIP_SDK_CHECKOUT" (
  goto :sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_SKIP_SDK_STDLIB" (
  goto :sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_SKIP_SDK_DISPATCH" (
  goto :sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_SKIP_SDK_FOUNDATION" (
  goto :sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_SKIP_SDK_XCTEST" (
  goto :sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_SKIP_SDK_DISPATCH_TEST" (
  goto :sw_validate_parameter_bool
) else if "%PARAMETER%"=="SW_SKIP_SDK_FOUNDATION_TEST" (
  goto :sw_validate_parameter_bool
)
endlocal
exit /b

:sw_validate_parameter_bool
call :sw_validate_bool_value %VALUE%
if errorlevel 1 goto :sw_validate_parameter_fail
endlocal
exit /b

:sw_validate_parameter_fail
%SW_LOG_ERROR% --message="%PARAMETER% - Invalid value: %VALUE%"
endlocal
exit /b 1



rem ###########################################################################
:sw_normalize_parameters_for_wizard

call :sw_normalize_bool_parameter_for_wizard SW_OBJC_PATCH_ENABLED
call :sw_normalize_bool_parameter_for_wizard SW_STDLIB_PATCH_ENABLED
call :sw_normalize_bool_parameter_for_wizard SW_SKIP_ICU
call :sw_normalize_bool_parameter_for_wizard SW_SKIP_TOOLCHAIN
call :sw_normalize_bool_parameter_for_wizard SW_SKIP_TOOLCHAIN_SWIFT_TEST
call :sw_normalize_bool_parameter_for_wizard SW_SKIP_ZLIB
call :sw_normalize_bool_parameter_for_wizard SW_SKIP_XML2
call :sw_normalize_bool_parameter_for_wizard SW_SKIP_CURL
call :sw_normalize_bool_parameter_for_wizard SW_SKIP_SDK
call :sw_normalize_bool_parameter_for_wizard SW_SKIP_SDK_CHECKOUT
call :sw_normalize_bool_parameter_for_wizard SW_SKIP_SDK_STDLIB
call :sw_normalize_bool_parameter_for_wizard SW_SKIP_SDK_DISPATCH
call :sw_normalize_bool_parameter_for_wizard SW_SKIP_SDK_FOUNDATION
call :sw_normalize_bool_parameter_for_wizard SW_SKIP_SDK_XCTEST
call :sw_normalize_bool_parameter_for_wizard SW_SKIP_SDK_DISPATCH_TEST
call :sw_normalize_bool_parameter_for_wizard SW_SKIP_SDK_FOUNDATION_TEST

exit /b



rem ###########################################################################
:sw_normalize_parameters_for_saving

call :sw_normalize_bool_parameter_for_saving SW_OBJC_PATCH_ENABLED
call :sw_normalize_bool_parameter_for_saving SW_STDLIB_PATCH_ENABLED
call :sw_normalize_bool_parameter_for_saving SW_SKIP_ICU
call :sw_normalize_bool_parameter_for_saving SW_SKIP_TOOLCHAIN
call :sw_normalize_bool_parameter_for_saving SW_SKIP_TOOLCHAIN_SWIFT_TEST
call :sw_normalize_bool_parameter_for_saving SW_SKIP_ZLIB
call :sw_normalize_bool_parameter_for_saving SW_SKIP_XML2
call :sw_normalize_bool_parameter_for_saving SW_SKIP_CURL
call :sw_normalize_bool_parameter_for_saving SW_SKIP_SDK
call :sw_normalize_bool_parameter_for_saving SW_SKIP_SDK_CHECKOUT
call :sw_normalize_bool_parameter_for_saving SW_SKIP_SDK_STDLIB
call :sw_normalize_bool_parameter_for_saving SW_SKIP_SDK_DISPATCH
call :sw_normalize_bool_parameter_for_saving SW_SKIP_SDK_FOUNDATION
call :sw_normalize_bool_parameter_for_saving SW_SKIP_SDK_XCTEST
call :sw_normalize_bool_parameter_for_saving SW_SKIP_SDK_DISPATCH_TEST
call :sw_normalize_bool_parameter_for_saving SW_SKIP_SDK_FOUNDATION_TEST

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
echo.  1. master
echo.  2. 5.3

set /p SW_BRANCH_NUM="Enter branch number to build (%SW_BRANCH_NUM%): "

if "%SW_BRANCH_NUM%"=="1" (
  set SW_SWIFT_BRANCH_SPEC=master
) else if "%SW_BRANCH_NUM%"=="2" (
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
:sw_ask_directories

set /p SW_SOURCES_DIR="Enter directory for source files (%SW_SOURCES_DIR%): "
set /p SW_BUILD_DIR="Enter directory for build output (%SW_BUILD_DIR%): "
set /p SW_INSTALL_DIR="Enter directory to install into (%SW_INSTALL_DIR%): "

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
call :sw_ask_swift_test
call :sw_ask_dispatch_test
call :sw_ask_foundation_test

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
:sw_ask_dispatch_test
set SW_ORIGINAL_VALUE=%SW_SKIP_SDK_DISPATCH_TEST%

:sw_ask_dispatch_test_input
set /p SW_SKIP_SDK_DISPATCH_TEST="Skip Dispatch test (%SW_SKIP_SDK_DISPATCH_TEST%)?: "
call :sw_normalize_bool_input SW_SKIP_SDK_DISPATCH_TEST
call :sw_validate_bool_input SW_SKIP_SDK_DISPATCH_TEST
if errorlevel 1 (
  set SW_SKIP_SDK_DISPATCH_TEST=%SW_ORIGINAL_VALUE%
  goto sw_ask_dispatch_test_input
)

exit /b



rem ###########################################################################
:sw_ask_foundation_test
set SW_ORIGINAL_VALUE=%SW_SKIP_SDK_FOUNDATION_TEST%

:sw_ask_foundation_test_input
set /p SW_SKIP_SDK_FOUNDATION_TEST="Skip Foundation test (%SW_SKIP_SDK_FOUNDATION_TEST%)?: "
call :sw_normalize_bool_input SW_SKIP_SDK_FOUNDATION_TEST
call :sw_validate_bool_input SW_SKIP_SDK_FOUNDATION_TEST
if errorlevel 1 (
  set SW_SKIP_SDK_FOUNDATION_TEST=%SW_ORIGINAL_VALUE%
  goto sw_ask_foundation_test_input
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
