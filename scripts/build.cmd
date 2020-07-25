@echo off

setlocal enabledelayedexpansion

set SW_CONFIG_FILE=config.cmd

call :sw_parse_arguments %* && call :sw_validate_parameters
if errorlevel 1 goto :eof

call scripts\tools\vs-env.cmd -arch=x64 -host_arch=x64

echo Using configuration from %SW_CONFIG_FILE%
call %SW_CONFIG_FILE%

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
echo Swift @objc patch:       %SW_EXPERIMENTAL_OBJC_PATCH_ENABLED%
echo Swift print patch:       %SW_STDLIB_PATCH_ENABLED%
echo.
echo Swift test enabled:      %SW_SWIFT_TEST_ENABLED%
echo Dispatch test enabled:   %SW_DISPATCH_TEST_ENABLED%
echo Foundation test enabled: %SW_FOUNDATION_TEST_ENABLED%
echo.

set SW_WORKSPACE=%CD%
set SW_JOBS_DIR=%SW_WORKSPACE%\scripts\workflows\jobs
set SW_ARTIFACTS_DIR=%SW_INSTALL_DIR%
set SW_IGNORE_TEST_FAILURES=1

call %SW_JOBS_DIR%\icu.cmd^
 && call %SW_JOBS_DIR%\toolchain.cmd^
 && call %SW_JOBS_DIR%\zlib.cmd^
 && call %SW_JOBS_DIR%\libxml2.cmd^
 && call %SW_JOBS_DIR%\curl.cmd^
 && call %SW_JOBS_DIR%\sdk.cmd
 
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
