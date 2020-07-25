@echo off

setlocal enabledelayedexpansion

set SW_INTERACTIVE=YES

set SW_SWIFT_BRANCH_SPEC=master
set SW_SWIFT_SDK_SPEC=apple
set SW_SOURCES_DIR=%CD%\w\s
set SW_BUILD_DIR=%CD%\w\b
set SW_INSTALL_DIR=%CD%\w\i
set SW_OBJC_PATCH_ENABLED=NO
set SW_STDLIB_PATCH_ENABLED=NO
set SW_SWIFT_TEST_ENABLED=YES
set SW_DISPATCH_TEST_ENABLED=YES
set SW_FOUNDATION_TEST_ENABLED=YES
set SW_CONFIG_FILE=%CD%\config.cmd

call :sw_parse_arguments %* && call :sw_validate_parameters
if errorlevel 1 goto :eof

call :sw_normalize_bool_parameter_for_wizard SW_OBJC_PATCH_ENABLED
call :sw_normalize_bool_parameter_for_wizard SW_SWIFT_TEST_ENABLED
call :sw_normalize_bool_parameter_for_wizard SW_DISPATCH_TEST_ENABLED
call :sw_normalize_bool_parameter_for_wizard SW_FOUNDATION_TEST_ENABLED
call :sw_normalize_bool_parameter_for_wizard SW_STDLIB_PATCH_ENABLED

if "%SW_INTERACTIVE%"=="NO" (
  goto configure
)

if /i "%SW_SWIFT_BRANCH_SPEC%"=="master" (
  set SW_BRANCH_NUM=1
) else if /i "%SW_SWIFT_BRANCH_SPEC%"=="5.3" (
  set SW_BRANCH_NUM=2
) else if /i "%SW_SWIFT_BRANCH_SPEC%"=="5.2" (
  set SW_BRANCH_NUM=3
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
call :sw_ask_swift_test
call :sw_ask_dispatch_test
call :sw_ask_foundation_test
call :sw_ask_config_file

:configure
if "%SW_SWIFT_BRANCH_SPEC%"=="5.2" (
  set SW_ICU_VERSION=64
) else (
  set SW_ICU_VERSION=67
)

set SW_CURL_VERSION=development
set SW_XML2_VERSION=development
set SW_ZLIB_VERSION=1.2.11

call :sw_normalize_parameters_for_saving

echo.
echo Swift branch spec:       %SW_SWIFT_BRANCH_SPEC%
echo Swift SDK spec:          %SW_SWIFT_SDK_SPEC%
echo Source files directory:  %SW_SOURCES_DIR%
echo Build output directory:  %SW_BUILD_DIR%
echo Install directory:       %SW_INSTALL_DIR%
echo.
echo CURL version:            %SW_CURL_VERSION%
echo ICU version:             %SW_ICU_VERSION%
echo XML2 version:            %SW_XML2_VERSION%
echo ZLIB version:            %SW_ZLIB_VERSION%
echo.
echo Swift @objc patch:       %SW_OBJC_PATCH_ENABLED%
echo Swift print patch:       %SW_STDLIB_PATCH_ENABLED%
echo.
echo Swift test enabled:      %SW_SWIFT_TEST_ENABLED%
echo Dispatch test enabled:   %SW_DISPATCH_TEST_ENABLED%
echo Foundation test enabled: %SW_FOUNDATION_TEST_ENABLED%

echo Configuration file:      %SW_CONFIG_FILE%
echo.

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
echo.>>%SW_CONFIG_FILE%
echo set SW_CURL_VERSION=%SW_CURL_VERSION%>>%SW_CONFIG_FILE%
echo set SW_ICU_VERSION=%SW_ICU_VERSION%>>%SW_CONFIG_FILE%
echo set SW_XML2_VERSION=%SW_XML2_VERSION%>>%SW_CONFIG_FILE%
echo set SW_ZLIB_VERSION=%SW_ZLIB_VERSION%>>%SW_CONFIG_FILE%
echo.>>%SW_CONFIG_FILE%
echo set SW_EXPERIMENTAL_OBJC_PATCH_ENABLED=%SW_OBJC_PATCH_ENABLED%>>%SW_CONFIG_FILE%
echo set SW_STDLIB_PATCH_ENABLED=%SW_STDLIB_PATCH_ENABLED%>>%SW_CONFIG_FILE%
echo.>>%SW_CONFIG_FILE%
echo set SW_SWIFT_TEST_ENABLED=%SW_SWIFT_TEST_ENABLED%>>%SW_CONFIG_FILE%
echo set SW_DISPATCH_TEST_ENABLED=%SW_DISPATCH_TEST_ENABLED%>>%SW_CONFIG_FILE%
echo set SW_FOUNDATION_TEST_ENABLED=%SW_FOUNDATION_TEST_ENABLED%>>%SW_CONFIG_FILE%

echo Configuration saved. Run build.cmd.

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
if "%NEXT_ARG%"=="SW_SWIFT_TEST_ENABLED"                goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_DISPATCH_TEST_ENABLED"             goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_FOUNDATION_TEST_ENABLED"           goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_OBJC_PATCH_ENABLED"                goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SW_STDLIB_PATCH_ENABLED"              goto sw_parse_arguments_accept

if not defined CURRENT_ARG goto sw_parse_argumens_end

if "%CURRENT_ARG%"=="--interactive" (                   set NEXT_ARG=SW_INTERACTIVE
) else if "%CURRENT_ARG%"=="--branch" (                 set NEXT_ARG=SW_SWIFT_BRANCH_SPEC
) else if "%CURRENT_ARG%"=="--sdk" (                    set NEXT_ARG=SW_SWIFT_SDK_SPEC
) else if "%CURRENT_ARG%"=="--sources-dir" (            set NEXT_ARG=SW_SOURCES_DIR
) else if "%CURRENT_ARG%"=="--build-dir" (              set NEXT_ARG=SW_BUILD_DIR
) else if "%CURRENT_ARG%"=="--install-dir" (            set NEXT_ARG=SW_INSTALL_DIR
) else if "%CURRENT_ARG%"=="--config" (                 set NEXT_ARG=SW_CONFIG_FILE
) else if "%CURRENT_ARG%"=="--test-swift" (             set NEXT_ARG=SW_SWIFT_TEST_ENABLED
) else if "%CURRENT_ARG%"=="--test-dispatch" (          set NEXT_ARG=SW_DISPATCH_TEST_ENABLED
) else if "%CURRENT_ARG%"=="--test-foundation" (        set NEXT_ARG=SW_FOUNDATION_TEST_ENABLED
) else if "%CURRENT_ARG%"=="--enable-no-objc-patch" (   set NEXT_ARG=SW_OBJC_PATCH_ENABLED
) else if "%CURRENT_ARG%"=="--enable-print-patch" (     set NEXT_ARG=SW_STDLIB_PATCH_ENABLED
) else if "%CURRENT_ARG%"=="--help" (                   goto help
) else (
  echo Unknown argument: %CURRENT_ARG%
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
for %%G in (SW_INTERACTIVE SW_SWIFT_BRANCH_SPEC SW_SWIFT_SDK_SPEC SW_SOURCES_DIR SW_BUILD_DIR SW_INSTALL_DIR SW_CONFIG_FILE SW_SWIFT_TEST_ENABLED SW_DISPATCH_TEST_ENABLED SW_FOUNDATION_TEST_ENABLED SW_OBJC_PATCH_ENABLED SW_STDLIB_PATCH_ENABLED) do (
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
  if /i not "%VALUE%"=="master" if /i not "%VALUE%"=="5.3" if /i not "%VALUE%"=="5.2" goto :sw_validate_parameter_fail
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
) else if "%PARAMETER%"=="SW_SWIFT_TEST_ENABLED" (
  if /i not "%VALUE%"=="YES" if /i not "%VALUE%"=="NO" (
    goto :sw_validate_parameter_fail
  )
) else if "%PARAMETER%"=="SW_DISPATCH_TEST_ENABLED" (
  if /i not "%VALUE%"=="YES" if /i not "%VALUE%"=="NO" (
    goto :sw_validate_parameter_fail
  )
) else if "%PARAMETER%"=="SW_FOUNDATION_TEST_ENABLED" (
  if /i not "%VALUE%"=="YES" if /i not "%VALUE%"=="NO" (
    goto :sw_validate_parameter_fail
  )
) else if "%PARAMETER%"=="SW_OBJC_PATCH_ENABLED" (
  if /i not "%VALUE%"=="YES" if /i not "%VALUE%"=="NO" (
    goto :sw_validate_parameter_fail
  )
) else if "%PARAMETER%"=="SW_STDLIB_PATCH_ENABLED" (
  if /i not "%VALUE%"=="YES" if /i not "%VALUE%"=="NO" (
    goto :sw_validate_parameter_fail
  )
)
endlocal
exit /b

:sw_validate_parameter_fail
echo %PARAMETER% - Invalid value: %VALUE%
endlocal
exit /b 1



rem ###########################################################################
:sw_normalize_parameters_for_wizard

call :sw_normalize_bool_parameter_for_wizard SW_STDLIB_PATCH_ENABLED
call :sw_normalize_bool_parameter_for_wizard SW_OBJC_PATCH_ENABLED
call :sw_normalize_bool_parameter_for_wizard SW_SWIFT_TEST_ENABLED
call :sw_normalize_bool_parameter_for_wizard SW_DISPATCH_TEST_ENABLED
call :sw_normalize_bool_parameter_for_wizard SW_FOUNDATION_TEST_ENABLED

exit /b



rem ###########################################################################
:sw_normalize_parameters_for_saving

call :sw_normalize_bool_parameter_for_saving SW_STDLIB_PATCH_ENABLED
call :sw_normalize_bool_parameter_for_saving SW_OBJC_PATCH_ENABLED
call :sw_normalize_bool_parameter_for_saving SW_SWIFT_TEST_ENABLED
call :sw_normalize_bool_parameter_for_saving SW_DISPATCH_TEST_ENABLED
call :sw_normalize_bool_parameter_for_saving SW_FOUNDATION_TEST_ENABLED

exit /b



rem ###########################################################################
:sw_normalize_bool_parameter_for_wizard <parameter>
setlocal enabledelayedexpansion

set PARAMETER=%1
set VALUE=!%PARAMETER%!

if "%VALUE%"=="YES" set VALUE=Y
if "%VALUE%"=="NO" set VALUE=N

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
:sw_ask_branch
set SW_ORIGINAL_VALUE=%SW_BRANCH_NUM%

:sw_ask_branch_input
echo Available branches:
echo.  1. master
echo.  2. 5.3
echo.  3. 5.2

set /p SW_BRANCH_NUM="Enter branch number to build (%SW_BRANCH_NUM%): "

if "%SW_BRANCH_NUM%"=="1" (
  set SW_SWIFT_BRANCH_SPEC=master
) else if "%SW_BRANCH_NUM%"=="2" (
  set SW_SWIFT_BRANCH_SPEC=5.3
) else if "%SW_BRANCH_NUM%"=="3" (
  set SW_SWIFT_BRANCH_SPEC=5.2
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
:sw_ask_swift_test
set SW_ORIGINAL_VALUE=%SW_SWIFT_TEST_ENABLED%

:sw_ask_swift_test_input
set /p SW_SWIFT_TEST_ENABLED="Enable Swift test (%SW_SWIFT_TEST_ENABLED%)?: "
call :sw_normalize_bool_input SW_SWIFT_TEST_ENABLED
call :sw_validate_bool_input SW_SWIFT_TEST_ENABLED
if errorlevel 1 (
  set SW_SWIFT_TEST_ENABLED=%SW_ORIGINAL_VALUE%
  goto sw_ask_swift_test_input
)

exit /b



rem ###########################################################################
:sw_ask_dispatch_test
set SW_ORIGINAL_VALUE=%SW_DISPATCH_TEST_ENABLED%

:sw_ask_dispatch_test_input
set /p SW_DISPATCH_TEST_ENABLED="Enable Dispatch test (%SW_DISPATCH_TEST_ENABLED%)?: "
call :sw_normalize_bool_input SW_DISPATCH_TEST_ENABLED
call :sw_validate_bool_input SW_DISPATCH_TEST_ENABLED
if errorlevel 1 (
  set SW_DISPATCH_TEST_ENABLED=%SW_ORIGINAL_VALUE%
  goto sw_ask_dispatch_test_input
)

exit /b



rem ###########################################################################
:sw_ask_foundation_test
set SW_ORIGINAL_VALUE=%SW_FOUNDATION_TEST_ENABLED%

:sw_ask_foundation_test_input
set /p SW_FOUNDATION_TEST_ENABLED="Enable Foundation test (%SW_FOUNDATION_TEST_ENABLED%)?: "
call :sw_normalize_bool_input SW_FOUNDATION_TEST_ENABLED
call :sw_validate_bool_input SW_FOUNDATION_TEST_ENABLED
if errorlevel 1 (
  set SW_FOUNDATION_TEST_ENABLED=%SW_ORIGINAL_VALUE%
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
