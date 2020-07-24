@echo off

setlocal enabledelayedexpansion

set SWW_INTERACTIVE=YES
set SWW_SAVE_CONFIG_DEFAULT=Y

set SWW_BRANCH_NUM_DEFAULT=1
set SWW_SWIFT_BRANCH_SPEC_DEFAULT=master
set SWW_SOURCES_DIR_DEFAULT=%CD%\w\s
set SWW_BUILD_DIR_DEFAULT=%CD%\w\b
set SWW_INSTALL_DIR_DEFAULT=%CD%\w\i
set SWW_OBJC_PATCH_ENABLED_DEFAULT=N
set SWW_STDLIB_PATCH_ENABLED_DEFAULT=N
set SWW_SWIFT_TEST_ENABLED_DEFAULT=Y
set SWW_DISPATCH_TEST_ENABLED_DEFAULT=Y
set SWW_FOUNDATION_TEST_ENABLED_DEFAULT=Y
set SWW_CONFIG_FILE_DEFAULT=%CD%\config.cmd

call :sw_parse_arguments %* && call :sw_validate_parameters
if errorlevel 1 goto :eof

if /i "%SWW_SWIFT_BRANCH_SPEC_DEFAULT%"=="master" (
  set SWW_BRANCH_NUM_DEFAULT=1
) else if /i "%SWW_SWIFT_BRANCH_SPEC_DEFAULT%"=="5.3" (
  set SWW_BRANCH_NUM_DEFAULT=2
) else if /i "%SWW_SWIFT_BRANCH_SPEC_DEFAULT%"=="5.2" (
  set SWW_BRANCH_NUM_DEFAULT=3
)

call :sw_normalize_bool_parameter_for_wizard SWW_SWIFT_TEST_ENABLED_DEFAULT
call :sw_normalize_bool_parameter_for_wizard SWW_DISPATCH_TEST_ENABLED_DEFAULT
call :sw_normalize_bool_parameter_for_wizard SWW_FOUNDATION_TEST_ENABLED_DEFAULT
call :sw_normalize_bool_parameter_for_wizard SWW_OBJC_PATCH_ENABLED_DEFAULT
call :sw_normalize_bool_parameter_for_wizard SWW_STDLIB_PATCH_ENABLED_DEFAULT

if /i [%SWW_INTERACTIVE%]==[NO] (
  set SWW_SWIFT_BRANCH_SPEC=%SWW_SWIFT_BRANCH_SPEC_DEFAULT%
  set SWW_SOURCES_DIR=%SWW_SOURCES_DIR_DEFAULT%
  set SWW_BUILD_DIR=%SWW_BUILD_DIR_DEFAULT%
  set SWW_INSTALL_DIR=%SWW_INSTALL_DIR_DEFAULT%
  set SWW_SWIFT_TEST_ENABLED=%SWW_SWIFT_TEST_ENABLED_DEFAULT%
  set SWW_DISPATCH_TEST_ENABLED=%SWW_DISPATCH_TEST_ENABLED_DEFAULT%
  set SWW_FOUNDATION_TEST_ENABLED=%SWW_FOUNDATION_TEST_ENABLED_DEFAULT%
  set SWW_CONFIG_FILE=%SWW_CONFIG_FILE_DEFAULT%
  set SWW_OBJC_PATCH_ENABLED=%SWW_OBJC_PATCH_ENABLED_DEFAULT%
  set SWW_STDLIB_PATCH_ENABLED=%SWW_STDLIB_PATCH_ENABLED_DEFAULT%
  goto configure
)

:wizard-start

call :sw_normalize_parameters_for_wizard

:ask-branch

echo Available branches:
echo.  1. master
echo.  2. 5.3
echo.  3. 5.2

set SWW_BRANCH_NUM=%SWW_BRANCH_NUM_DEFAULT%
set /p SWW_BRANCH_NUM="Enter branch number to build (%SWW_BRANCH_NUM_DEFAULT%): "

if [%SWW_BRANCH_NUM%]==[1] (
  set SWW_SWIFT_BRANCH_SPEC=master
) else if [%SWW_BRANCH_NUM%]==[2] (
  set SWW_SWIFT_BRANCH_SPEC=5.3
) else if [%SWW_BRANCH_NUM%]==[3] (
  set SWW_SWIFT_BRANCH_SPEC=5.2
) else (
  goto ask-branch
)
set SWW_BRANCH_NUM_DEFAULT=%SWW_BRANCH_NUM%

:ask-src-dir
set SWW_SOURCES_DIR=%SWW_SOURCES_DIR_DEFAULT%
set /p SWW_SOURCES_DIR="Enter directory for source files (%SWW_SOURCES_DIR_DEFAULT%): "
set SWW_SOURCES_DIR_DEFAULT=%SWW_SOURCES_DIR%

:ask-build-dir
set SWW_BUILD_DIR=%SWW_BUILD_DIR_DEFAULT%
set /p SWW_BUILD_DIR="Enter directory for build output (%SWW_BUILD_DIR_DEFAULT%): "
set SWW_BUILD_DIR_DEFAULT=%SWW_BUILD_DIR%

:ask-install-dir
set SWW_INSTALL_DIR=%SWW_INSTALL_DIR_DEFAULT%
set /p SWW_INSTALL_DIR="Enter directory to install into (%SWW_INSTALL_DIR_DEFAULT%): "
set SWW_INSTALL_DIR_DEFAULT=%SWW_INSTALL_DIR%

:ask-swift-patch
set SWW_OBJC_PATCH_ENABLED=%SWW_OBJC_PATCH_ENABLED_DEFAULT%
set /p SWW_OBJC_PATCH_ENABLED="Apply @objc patch (%SWW_OBJC_PATCH_ENABLED_DEFAULT%)?: "
if /i not [%SWW_OBJC_PATCH_ENABLED%]==[Y] if /i not [%SWW_OBJC_PATCH_ENABLED%]==[N] (
  goto ask-swift-patch  
)
set SWW_OBJC_PATCH_ENABLED_DEFAULT=%SWW_OBJC_PATCH_ENABLED%

:ask-stdlib-patch
set SWW_STDLIB_PATCH_ENABLED=%SWW_STDLIB_PATCH_ENABLED_DEFAULT%
set /p SWW_STDLIB_PATCH_ENABLED="Apply print flush patch (%SWW_STDLIB_PATCH_ENABLED_DEFAULT%)?: "
if /i not [%SWW_STDLIB_PATCH_ENABLED%]==[Y] if /i not [%SWW_STDLIB_PATCH_ENABLED%]==[N] (
  goto ask-stdlib-patch  
)
set SWW_STDLIB_PATCH_ENABLED_DEFAULT=%SWW_STDLIB_PATCH_ENABLED%

:ask-swift-test
set SWW_SWIFT_TEST_ENABLED=%SWW_SWIFT_TEST_ENABLED_DEFAULT%
set /p SWW_SWIFT_TEST_ENABLED="Enable Swift test (%SWW_SWIFT_TEST_ENABLED_DEFAULT%)?: "
if /i not [%SWW_SWIFT_TEST_ENABLED%]==[Y] if /i not [%SWW_SWIFT_TEST_ENABLED%]==[N] (
  goto ask-swift-test  
)
set SWW_SWIFT_TEST_ENABLED_DEFAULT=%SWW_SWIFT_TEST_ENABLED%

:ask-dispatch-test
set SWW_DISPATCH_TEST_ENABLED=%SWW_DISPATCH_TEST_ENABLED_DEFAULT%
set /p SWW_DISPATCH_TEST_ENABLED="Enable Dispatch test (%SWW_DISPATCH_TEST_ENABLED_DEFAULT%)?: "
if /i not [%SWW_DISPATCH_TEST_ENABLED%]==[Y] if /i not [%SWW_DISPATCH_TEST_ENABLED%]==[N] (
  goto ask-dispatch-test  
)
set SWW_DISPATCH_TEST_ENABLED_DEFAULT=%SWW_DISPATCH_TEST_ENABLED%

:ask-foundation-test
set SWW_FOUNDATION_TEST_ENABLED=%SWW_FOUNDATION_TEST_ENABLED_DEFAULT%
set /p SWW_FOUNDATION_TEST_ENABLED="Enable Foundation test (%SWW_FOUNDATION_TEST_ENABLED_DEFAULT%)?: "
if [%SWW_FOUNDATION_TEST_ENABLED%]==[] (
  set SWW_FOUNDATION_TEST_ENABLED=%SWW_FOUNDATION_TEST_ENABLED_DEFAULT%
)
if /i not [%SWW_FOUNDATION_TEST_ENABLED%]==[Y] if /i not [%SWW_FOUNDATION_TEST_ENABLED%]==[N] (
  goto ask-foundation-test  
)
set SWW_FOUNDATION_TEST_ENABLED_DEFAULT=%SWW_FOUNDATION_TEST_ENABLED%

:ask-config-file
set /p SWW_CONFIG_FILE="Enter configuration file name to save (%SWW_CONFIG_FILE_DEFAULT%): "
if [%SWW_CONFIG_FILE%]==[] (
  set SWW_CONFIG_FILE=%SWW_CONFIG_FILE_DEFAULT%
)
set SWW_CONFIG_FILE_DEFAULT=%SWW_CONFIG_FILE%

:configure
if [%SWW_SWIFT_BRANCH_SPEC%]==[5.2] (
  set SWW_ICU_VERSION=64
) else (
  set SWW_ICU_VERSION=67
)

set SWW_CURL_VERSION=development
set SWW_XML2_VERSION=development
set SWW_ZLIB_VERSION=1.2.11

call :sw_normalize_parameters_for_saving

echo.
echo Swift branch spec:       %SWW_SWIFT_BRANCH_SPEC%
echo Source files directory:  %SWW_SOURCES_DIR%
echo Build output directory:  %SWW_BUILD_DIR%
echo Install directory:       %SWW_INSTALL_DIR%
echo.
echo CURL version:            %SWW_CURL_VERSION%
echo ICU version:             %SWW_ICU_VERSION%
echo XML2 version:            %SWW_XML2_VERSION%
echo ZLIB version:            %SWW_ZLIB_VERSION%
echo.
echo Swift @objc patch:       %SWW_OBJC_PATCH_ENABLED%
echo Swift print patch:       %SWW_STDLIB_PATCH_ENABLED%
echo.
echo Swift test enabled:      %SWW_SWIFT_TEST_ENABLED%
echo Dispatch test enabled:   %SWW_DISPATCH_TEST_ENABLED%
echo Foundation test enabled: %SWW_FOUNDATION_TEST_ENABLED%

echo Configuration file:      %SWW_CONFIG_FILE%
echo.

if /i [%SWW_INTERACTIVE%]==[NO] goto save-config

:ask-save
set SWW_SAVE_CONFIG=%SWW_SAVE_CONFIG_DEFAULT%
set /p SWW_SAVE_CONFIG="Do you want to save this configuration? (Y/n): "
if /i [%SWW_SAVE_CONFIG%]==[Y] (
  goto save-config
) else if /i [%SWW_SAVE_CONFIG%]==[N] (
  echo.
  goto wizard-start
) else (
  goto ask-save
)

:save-config
echo set SW_SWIFT_BRANCH_SPEC=%SWW_SWIFT_BRANCH_SPEC%>%SWW_CONFIG_FILE%
echo set SW_SOURCES_DIR=%SWW_SOURCES_DIR%>>%SWW_CONFIG_FILE%
echo set SW_BUILD_DIR=%SWW_BUILD_DIR%>>%SWW_CONFIG_FILE%
echo set SW_INSTALL_DIR=%SWW_INSTALL_DIR%>>%SWW_CONFIG_FILE%
echo.>>%SWW_CONFIG_FILE%
echo set SW_CURL_VERSION=%SWW_CURL_VERSION%>>%SWW_CONFIG_FILE%
echo set SW_ICU_VERSION=%SWW_ICU_VERSION%>>%SWW_CONFIG_FILE%
echo set SW_XML2_VERSION=%SWW_XML2_VERSION%>>%SWW_CONFIG_FILE%
echo set SW_ZLIB_VERSION=%SWW_ZLIB_VERSION%>>%SWW_CONFIG_FILE%
echo.>>%SWW_CONFIG_FILE%
echo set SW_EXPERIMENTAL_OBJC_PATCH_ENABLED=%SWW_OBJC_PATCH_ENABLED%>>%SWW_CONFIG_FILE%
echo set SW_STDLIB_PATCH_ENABLED=%SWW_STDLIB_PATCH_ENABLED%>>%SWW_CONFIG_FILE%
echo.>>%SWW_CONFIG_FILE%
echo set SW_SWIFT_TEST_ENABLED=%SWW_SWIFT_TEST_ENABLED%>>%SWW_CONFIG_FILE%
echo set SW_DISPATCH_TEST_ENABLED=%SWW_DISPATCH_TEST_ENABLED%>>%SWW_CONFIG_FILE%
echo set SW_FOUNDATION_TEST_ENABLED=%SWW_FOUNDATION_TEST_ENABLED%>>%SWW_CONFIG_FILE%

echo Configuration saved. Run build.cmd.

goto :eof
endlocal



rem ###########################################################################
:sw_parse_arguments <arguments...>
:sw_parse_arguments_start
set CURRENT_ARG=%~1

if "%NEXT_ARG%"=="SWW_INTERACTIVE"                      goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SWW_SWIFT_BRANCH_SPEC_DEFAULT"        goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SWW_SOURCES_DIR_DEFAULT"              goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SWW_BUILD_DIR_DEFAULT"                goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SWW_INSTALL_DIR_DEFAULT"              goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SWW_CONFIG_FILE_DEFAULT"              goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SWW_SWIFT_TEST_ENABLED_DEFAULT"       goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SWW_DISPATCH_TEST_ENABLED_DEFAULT"    goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SWW_FOUNDATION_TEST_ENABLED_DEFAULT"  goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SWW_OBJC_PATCH_ENABLED_DEFAULT"       goto sw_parse_arguments_accept
if "%NEXT_ARG%"=="SWW_STDLIB_PATCH_ENABLED_DEFAULT"     goto sw_parse_arguments_accept

if not defined CURRENT_ARG goto sw_parse_argumens_end

if "%CURRENT_ARG%"=="--interactive" (                   set NEXT_ARG=SWW_INTERACTIVE
) else if "%CURRENT_ARG%"=="--branch" (                 set NEXT_ARG=SWW_SWIFT_BRANCH_SPEC_DEFAULT
) else if "%CURRENT_ARG%"=="--sources-dir" (            set NEXT_ARG=SWW_SOURCES_DIR_DEFAULT
) else if "%CURRENT_ARG%"=="--build-dir" (              set NEXT_ARG=SWW_BUILD_DIR_DEFAULT
) else if "%CURRENT_ARG%"=="--install-dir" (            set NEXT_ARG=SWW_INSTALL_DIR_DEFAULT
) else if "%CURRENT_ARG%"=="--config" (                 set NEXT_ARG=SWW_CONFIG_FILE_DEFAULT
) else if "%CURRENT_ARG%"=="--test-swift" (             set NEXT_ARG=SWW_SWIFT_TEST_ENABLED_DEFAULT
) else if "%CURRENT_ARG%"=="--test-dispatch" (          set NEXT_ARG=SWW_DISPATCH_TEST_ENABLED_DEFAULT
) else if "%CURRENT_ARG%"=="--test-foundation" (        set NEXT_ARG=SWW_FOUNDATION_TEST_ENABLED_DEFAULT
) else if "%CURRENT_ARG%"=="--enable-no-objc-patch" (   set NEXT_ARG=SWW_OBJC_PATCH_ENABLED_DEFAULT
) else if "%CURRENT_ARG%"=="--enable-print-patch" (     set NEXT_ARG=SWW_STDLIB_PATCH_ENABLED_DEFAULT
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
for %%G in (SWW_INTERACTIVE SWW_SWIFT_BRANCH_SPEC_DEFAULT SWW_SOURCES_DIR_DEFAULT SWW_BUILD_DIR_DEFAULT SWW_INSTALL_DIR_DEFAULT SWW_CONFIG_FILE_DEFAULT SWW_SWIFT_TEST_ENABLED_DEFAULT SWW_DISPATCH_TEST_ENABLED_DEFAULT SWW_FOUNDATION_TEST_ENABLED_DEFAULT SWW_OBJC_PATCH_ENABLED_DEFAULT SWW_STDLIB_PATCH_ENABLED_DEFAULT) do (
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

if "%PARAMETER%"=="SWW_INTERACTIVE" (
  if /i not "%VALUE%"=="YES" if /i not "%VALUE%"=="NO" goto :sw_validate_parameter_fail
) else if "%PARAMETER%"=="SWW_SWIFT_BRANCH_SPEC_DEFAULT" (
  if /i not "%VALUE%"=="master" if /i not "%VALUE%"=="5.3" if /i not "%VALUE%"=="5.2" goto :sw_validate_parameter_fail
) else if "%PARAMETER%"=="SWW_SOURCES_DIR_DEFAULT" (
  if "%VALUE%"=="" goto :sw_validate_parameter_fail
) else if "%PARAMETER%"=="SWW_BUILD_DIR_DEFAULT" (
  if "%VALUE%"=="" goto :sw_validate_parameter_fail
) else if "%PARAMETER%"=="SWW_INSTALL_DIR_DEFAULT" (
  if "%VALUE%"=="" goto :sw_validate_parameter_fail
) else if "%PARAMETER%"=="SWW_CONFIG_FILE_DEFAULT" (
  if "%VALUE%"=="" goto :sw_validate_parameter_fail
) else if "%PARAMETER%"=="SWW_SWIFT_TEST_ENABLED_DEFAULT" (
  if /i not "%VALUE%"=="YES" if /i not "%VALUE%"=="NO" (
    goto :sw_validate_parameter_fail
  )
) else if "%PARAMETER%"=="SWW_DISPATCH_TEST_ENABLED_DEFAULT" (
  if /i not "%VALUE%"=="YES" if /i not "%VALUE%"=="NO" (
    goto :sw_validate_parameter_fail
  )
) else if "%PARAMETER%"=="SWW_FOUNDATION_TEST_ENABLED_DEFAULT" (
  if /i not "%VALUE%"=="YES" if /i not "%VALUE%"=="NO" (
    goto :sw_validate_parameter_fail
  )
) else if "%PARAMETER%"=="SWW_OBJC_PATCH_ENABLED_DEFAULT" (
  if /i not "%VALUE%"=="YES" if /i not "%VALUE%"=="NO" (
    goto :sw_validate_parameter_fail
  )
) else if "%PARAMETER%"=="SWW_STDLIB_PATCH_ENABLED_DEFAULT" (
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

call :sw_normalize_bool_parameter_for_wizard SWW_STDLIB_PATCH_ENABLED
call :sw_normalize_bool_parameter_for_wizard SWW_OBJC_PATCH_ENABLED
call :sw_normalize_bool_parameter_for_wizard SWW_SWIFT_TEST_ENABLED
call :sw_normalize_bool_parameter_for_wizard SWW_DISPATCH_TEST_ENABLED
call :sw_normalize_bool_parameter_for_wizard SWW_FOUNDATION_TEST_ENABLED

exit /b



rem ###########################################################################
:sw_normalize_parameters_for_saving

call :sw_normalize_bool_parameter_for_saving SWW_STDLIB_PATCH_ENABLED
call :sw_normalize_bool_parameter_for_saving SWW_OBJC_PATCH_ENABLED
call :sw_normalize_bool_parameter_for_saving SWW_SWIFT_TEST_ENABLED
call :sw_normalize_bool_parameter_for_saving SWW_DISPATCH_TEST_ENABLED
call :sw_normalize_bool_parameter_for_saving SWW_FOUNDATION_TEST_ENABLED

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

endlocal
