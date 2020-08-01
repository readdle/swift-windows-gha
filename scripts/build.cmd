@echo off

setlocal enabledelayedexpansion

call "%~f0\..\tools\log.cmd" > nul

set SW_LOG_INFO=%SW_LOG_INFO% --scope build
set SW_LOG_ERROR=%SW_LOG_ERROR% --scope build

set SW_CONFIG_FILE=config.cmd

call :sw_parse_arguments %* && call :sw_validate_parameters
if errorlevel 1 goto :eof

call scripts\tools\vs-env.cmd -arch=x64 -host_arch=x64

echo Using configuration from %SW_CONFIG_FILE%
call %SW_CONFIG_FILE%

%SW_LOG_INFO%
%SW_LOG_INFO% --prefix="Swift branch spec:       " --message="%SW_SWIFT_BRANCH_SPEC%"
%SW_LOG_INFO% --prefix="Swift SDK spec:          " --message="%SW_SWIFT_SDK_SPEC%"
%SW_LOG_INFO% --prefix="Source files directory:  " --message="%SW_SOURCES_DIR%"
%SW_LOG_INFO% --prefix="Build output directory:  " --message="%SW_BUILD_DIR%"
%SW_LOG_INFO% --prefix="Install directory:       " --message="%SW_INSTALL_DIR%"
%SW_LOG_INFO%
%SW_LOG_INFO% --prefix="CURL version:            " --message="%SW_CURL_VERSION%"
%SW_LOG_INFO% --prefix="ICU version:             " --message="%SW_ICU_VERSION%"
%SW_LOG_INFO% --prefix="XML2 version:            " --message="%SW_XML2_VERSION%"
%SW_LOG_INFO% --prefix="ZLIB version:            " --message="%SW_ZLIB_VERSION%"
%SW_LOG_INFO%
%SW_LOG_INFO% --prefix="Swift @objc patch:       " --message="%SW_OBJC_PATCH_ENABLED%"
%SW_LOG_INFO% --prefix="Swift print patch:       " --message="%SW_STDLIB_PATCH_ENABLED%"
%SW_LOG_INFO%
%SW_LOG_INFO% --prefix="Swift test enabled:      " --message="%SW_SWIFT_TEST_ENABLED%"
%SW_LOG_INFO% --prefix="Dispatch test enabled:   " --message="%SW_DISPATCH_TEST_ENABLED%"
%SW_LOG_INFO% --prefix="Foundation test enabled: " --message="%SW_FOUNDATION_TEST_ENABLED%"
%SW_LOG_INFO%
%SW_LOG_INFO% --prefix="Configuration file:      " --message="%SW_CONFIG_FILE%"
%SW_LOG_INFO%


set SW_WORKSPACE=%CD%
set SW_JOBS_DIR=%SW_WORKSPACE%\scripts\workflows\jobs
set SW_ARTIFACTS_DIR=%SW_INSTALL_DIR%
set SW_IGNORE_TEST_FAILURES=1

call %SW_JOBS_DIR%\toolchain.cmd
REM call %SW_JOBS_DIR%\icu.cmd^
REM  && call %SW_JOBS_DIR%\toolchain.cmd^
REM  && call %SW_JOBS_DIR%\zlib.cmd^
REM  && call %SW_JOBS_DIR%\libxml2.cmd^
REM  && call %SW_JOBS_DIR%\curl.cmd^
REM  && call %SW_JOBS_DIR%\sdk.cmd
 
endlocal
goto :eof



rem ###########################################################################
:sw_parse_arguments <arguments...>
:sw_parse_arguments_start
set CURRENT_ARG=%~1

if "%NEXT_ARG%"=="SW_CONFIG_FILE" goto sw_parse_arguments_accept

if not defined CURRENT_ARG goto sw_parse_argumens_end

if "%CURRENT_ARG%"=="--config" (
  set NEXT_ARG=SW_CONFIG_FILE
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
for %%G in (SW_CONFIG_FILE) do (
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

if "%PARAMETER%"=="SW_CONFIG_FILE" (
  if "%VALUE%"=="" goto :sw_validate_parameter_fail
  if not exist "%VALUE%" (
    echo Configuration not found: %VALUE%
    goto :sw_validate_parameter_fail
  )
)

endlocal
exit /b

:sw_validate_parameter_fail
echo %PARAMETER% - Invalid value: %VALUE%
endlocal
exit /b 1
