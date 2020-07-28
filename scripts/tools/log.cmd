@echo off

if not defined SW_LOG_INITIALIZED call :init_log

setlocal enabledelayedexpansion

set SW_CURRENT_CMD=%0

rem *** Parse input arguments
:sw_parse_argument
set CURRENT_ARG=%1
if not defined CURRENT_ARG goto sw_parse_argumens_end

if [%NEXT_ARG%]==[SW_SCOPE] goto sw_parse_argument_accept
if [%NEXT_ARG%]==[SW_LEVEL] goto sw_parse_argument_accept
if [%NEXT_ARG%]==[SW_PREFIX] goto sw_parse_argument_accept
if [%NEXT_ARG%]==[SW_MESSAGE] goto sw_parse_argument_accept

if [%CURRENT_ARG%]==[--scope] set NEXT_ARG=SW_SCOPE
if [%CURRENT_ARG%]==[--level] set NEXT_ARG=SW_LEVEL
if [%CURRENT_ARG%]==[--prefix] set NEXT_ARG=SW_PREFIX
if [%CURRENT_ARG%]==[--message] set NEXT_ARG=SW_MESSAGE
if [%CURRENT_ARG%]==[--help] goto help

if not defined NEXT_ARG (
  call %SW_CURRENT_CMD% --scope log --level error --prefix "Unknown parameter:" --message "%CURRENT_ARG%"
  exit /b 1
)

goto :sw_parse_argument_next

:sw_parse_argument_accept
set %NEXT_ARG%=%CURRENT_ARG%
set NEXT_ARG=

:sw_parse_argument_next
shift
goto sw_parse_argument
:sw_parse_argumens_end



rem *** Check arguments
if not defined SW_LEVEL set SW_LEVEL=info
if /i not [%SW_LEVEL%]==[info] if /i not [%SW_LEVEL%]==[warning] if /i not [%SW_LEVEL%]==[error] (
  echo Unknown log level: %SW_LEVEL%
  exit /b 1
)
if /i [%SW_LEVEL%]==[info] (
  set SW_LEVEL=INF
  set SW_LEVEL_COLOR=%SW_LOG_GREEN%
) else if /i [%SW_LEVEL%]==[warning] (
  set SW_LEVEL=WRN
  set SW_LEVEL_COLOR=%SW_LOG_YELLOW%
) else if /i [%SW_LEVEL%]==[error] (
  set SW_LEVEL_COLOR=%SW_LOG_RED%%SW_LOG_BOLD%
  set SW_LEVEL=ERR
)

if defined SW_SCOPE call :escape_and_dequote SW_SCOPE %SW_SCOPE%
if defined SW_PREFIX call :escape_and_dequote SW_PREFIX %SW_PREFIX%
if defined SW_MESSAGE call :escape_and_dequote SW_MESSAGE %SW_MESSAGE%

rem *** Add spacers
if defined SW_SCOPE set "SW_SCOPE=%SW_SCOPE% "
if defined SW_PREFIX set "SW_PREFIX=%SW_PREFIX% "

echo.%SW_SCOPE%[%SW_LEVEL_COLOR%%SW_LEVEL%%SW_LOG_RESET%] %SW_LOG_MAGENTA%%SW_PREFIX%%SW_LOG_RESET%%SW_MESSAGE%

endlocal
goto :eof



rem ###########################################################################
:escape_and_dequote <out_var> <var>
setlocal enabledelayedexpansion

set OUT_VAR=%1
set "PARAM=%~2"

if defined PARAM (
  set "PARAM=!PARAM:<=^<!"
  set "PARAM=!PARAM:>=^>!"
)

(
  endlocal
  set "%OUT_VAR%=%PARAM%"
  exit /b
)



rem ###########################################################################
:help
call %SW_CURRENT_CMD% --scope help --message "Logs specified message with optional prefix and scope, marking it as one of three levels"
call %SW_CURRENT_CMD% --scope help
call %SW_CURRENT_CMD% --scope help --message "Parameters:"
call %SW_CURRENT_CMD% --scope help --prefix "--scope    " --message "the scope of logged message"
call %SW_CURRENT_CMD% --scope help --prefix "--level    " --message "desired log level. Valid values are ""info"", ""warning"" and ""error"""
call %SW_CURRENT_CMD% --scope help --prefix "--prefix   " --message "emphasized prefix of message body"
call %SW_CURRENT_CMD% --scope help --prefix "--message  " --message "message body to log"
goto :eof



rem ###########################################################################
:init_log

call :set_esc

set SW_LOG_RESET=%SW_ESC%[0m

set SW_LOG_BOLD=%SW_ESC%[1m
set SW_LOG_RED=%SW_ESC%[31m
set SW_LOG_GREEN=%SW_ESC%[32m
set SW_LOG_YELLOW=%SW_ESC%[33m
set SW_LOG_MAGENTA=%SW_ESC%[35m

set SW_LOG_INITIALIZED=Y

exit /b


rem ###########################################################################
:set_esc
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set SW_ESC=%%b
  exit /B 0
)
exit /B 0

endlocal
