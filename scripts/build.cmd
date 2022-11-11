@echo off

setlocal enabledelayedexpansion

call "%~dp0\workflows\configure-build-environment.cmd"
if errorlevel 1 exit /b

set SW_CONFIG_FILE=config.cmd

call :sw_parse_arguments %* && call :sw_validate_parameters
if errorlevel 1 goto :eof

call "%SW_WORKSPACE%\scripts\workflows\load-configuration.cmd"

:: Steps in workflow are executed in isolated environment.
:: Steps in build script has one global environment.
:: This option hints set-env script how to work with environment variables.
set SW_BUILD_ENVIRONMENT=script

call "%SW_WORKSPACE%\scripts\workflows\jobs\tools.cmd"^
 && call "%SW_WORKSPACE%\scripts\workflows\jobs\toolchain.cmd"^
 && call "%SW_WORKSPACE%\scripts\workflows\jobs\icu.cmd"^
 && call "%SW_WORKSPACE%\scripts\workflows\jobs\zlib.cmd"^
 && call "%SW_WORKSPACE%\scripts\workflows\jobs\libxml2.cmd"^
 && call "%SW_WORKSPACE%\scripts\workflows\jobs\curl.cmd"^
 && call "%SW_WORKSPACE%\scripts\workflows\jobs\sdk.cmd"^
 && call "%SW_WORKSPACE%\scripts\workflows\jobs\sqlite.cmd"^
 && call "%SW_WORKSPACE%\scripts\workflows\jobs\devtools.cmd"

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
goto sw_parse_arguments_next

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
  if "%VALUE%"=="" goto sw_validate_parameter_fail
  if not exist "%VALUE%" (
    %SW_LOG_BUILD_ERROR% --message="Configuration not found: %VALUE%"
    goto sw_validate_parameter_fail
  )
)

endlocal
exit /b

:sw_validate_parameter_fail
%SW_LOG_BUILD_ERROR% --message="%PARAMETER% - Invalid value: %VALUE%"
endlocal
exit /b 1
