@echo off

setlocal enabledelayedexpansion

set "SW_WORKSPACE=%~dp0\.."
call :sw_normalize_path SW_WORKSPACE "%SW_WORKSPACE%"

call "%SW_WORKSPACE%\scripts\tools\init-log.cmd"
set "SW_PRE_STEP=call ""%SW_WORKSPACE%\scripts\tools\pre-step.cmd"""

set SW_LOG_BUILD_INFO=%SW_LOG_INFO% --scope build
set SW_LOG_BUILD_WARNING=%SW_LOG_WARNING% --scope build
set SW_LOG_BUILD_ERROR=%SW_LOG_ERROR% --scope build

set SW_CONFIG_FILE=config.cmd

call :sw_parse_arguments %* && call :sw_validate_parameters
if errorlevel 1 goto :eof

set "SW_WORKSPACE=%~dp0\.."
call :sw_normalize_path SW_WORKSPACE %SW_WORKSPACE%
set SW_JOBS_DIR=%SW_WORKSPACE%\scripts\workflows\jobs

%SW_LOG_BUILD_INFO% --prefix="Using configuration from " --message="%SW_CONFIG_FILE%"
call %SW_CONFIG_FILE%

%SW_LOG_BUILD_INFO%
%SW_LOG_BUILD_INFO% --prefix="Workspace:               " --message="%SW_WORKSPACE%"
%SW_LOG_BUILD_INFO%
%SW_LOG_BUILD_INFO% --prefix="Swift branch spec:       " --message="%SW_SWIFT_BRANCH_SPEC%"
%SW_LOG_BUILD_INFO% --prefix="Swift SDK spec:          " --message="%SW_SWIFT_SDK_SPEC%"
%SW_LOG_BUILD_INFO% --prefix="Source files directory:  " --message="%SW_SOURCES_DIR%"
%SW_LOG_BUILD_INFO% --prefix="Build output directory:  " --message="%SW_BUILD_DIR%"
%SW_LOG_BUILD_INFO% --prefix="Install directory:       " --message="%SW_INSTALL_DIR%"
%SW_LOG_BUILD_INFO% --prefix="Artifacts directory:     " --message="%SW_ARTIFACTS_DIR%"
%SW_LOG_BUILD_INFO%
%SW_LOG_BUILD_INFO% --prefix="CURL version:            " --message="%SW_CURL_VERSION%"
%SW_LOG_BUILD_INFO% --prefix="ICU version:             " --message="%SW_ICU_VERSION%"
%SW_LOG_BUILD_INFO% --prefix="XML2 version:            " --message="%SW_XML2_VERSION%"
%SW_LOG_BUILD_INFO% --prefix="ZLIB version:            " --message="%SW_ZLIB_VERSION%"
%SW_LOG_BUILD_INFO%
%SW_LOG_BUILD_INFO% --prefix="Swift @objc patch:       " --message="%SW_OBJC_PATCH_ENABLED%"
%SW_LOG_BUILD_INFO% --prefix="Swift print patch:       " --message="%SW_STDLIB_PATCH_ENABLED%"
%SW_LOG_BUILD_INFO%
%SW_LOG_BUILD_INFO% --prefix="Swift test enabled:      " --message="%SW_SWIFT_TEST_ENABLED%"
%SW_LOG_BUILD_INFO% --prefix="Skip Dispatch test:      " --message="%SW_SKIP_SDK_DISPATCH_TEST%"
%SW_LOG_BUILD_INFO% --prefix="Skip Foundation test:    " --message="%SW_SKIP_SDK_FOUNDATION_TEST%"
%SW_LOG_BUILD_INFO%
if "%SW_SKIP_ICU%"=="YES"       ( %SW_LOG_BUILD_WARNING% --prefix="Job disabled:            " --message="ICU" )
if "%SW_SKIP_TOOLCHAIN%"=="YES" ( %SW_LOG_BUILD_WARNING% --prefix="Job disabled:            " --message="Toolchain" )
if "%SW_SKIP_ZLIB%"=="YES"      ( %SW_LOG_BUILD_WARNING% --prefix="Job disabled:            " --message="zlib" )
if "%SW_SKIP_XML2%"=="YES"      ( %SW_LOG_BUILD_WARNING% --prefix="Job disabled:            " --message="libxml2" )
if "%SW_SKIP_CURL%"=="YES"      ( %SW_LOG_BUILD_WARNING% --prefix="Job disabled:            " --message="curl" )
if "%SW_SKIP_SDK%"=="YES"       ( %SW_LOG_BUILD_WARNING% --prefix="Job disabled:            " --message="SDK" )
%SW_LOG_BUILD_INFO%

call scripts\tools\vs-env.cmd -arch=x64 -host_arch=x64

set SW_IGNORE_TEST_FAILURES=1

call %SW_JOBS_DIR%\icu.cmd^
 && call %SW_JOBS_DIR%\toolchain.cmd^
 && call %SW_JOBS_DIR%\zlib.cmd^
 && call %SW_JOBS_DIR%\libxml2.cmd^
 && call %SW_JOBS_DIR%\curl.cmd^
 && call %SW_JOBS_DIR%\sdk.cmd
 
endlocal
goto :eof



:: ###########################################################################
:sw_parse_arguments <arguments...>
:sw_parse_arguments_start
set CURRENT_ARG=%~1

if "%NEXT_ARG%"=="SW_CONFIG_FILE" goto sw_parse_arguments_accept

if not defined CURRENT_ARG goto sw_parse_argumens_end

if "%CURRENT_ARG%"=="--config" (
  set NEXT_ARG=SW_CONFIG_FILE
) else (
  %SW_LOG_BUILD_ERROR% --message="Unknown argument: %CURRENT_ARG%"
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



:: ###########################################################################
:sw_validate_parameters
setlocal enabledelayedexpansion
for %%G in (SW_CONFIG_FILE) do (
  call :sw_validate_parameter %%G
  if errorlevel 1 goto sw_validate_parameters_fail
)
endlocal
exit /b

:sw_validate_parameters_fail
endlocal
exit /b 1



:: ###########################################################################
:sw_validate_parameter <parameter>
setlocal enabledelayedexpansion

set PARAMETER=%1
set VALUE=!%PARAMETER%!

if "%PARAMETER%"=="SW_CONFIG_FILE" (
  if "%VALUE%"=="" goto :sw_validate_parameter_fail
  if not exist "%VALUE%" (
    %SW_LOG_BUILD_ERROR% --message="Configuration not found: %VALUE%"
    goto :sw_validate_parameter_fail
  )
)

endlocal
exit /b

:sw_validate_parameter_fail
%SW_LOG_BUILD_ERROR% --message="%PARAMETER% - Invalid value: %VALUE%"
endlocal
exit /b 1



:: ###########################################################################
:sw_normalize_path <output_var> <path>
set "%1=%~f2"
exit /b
