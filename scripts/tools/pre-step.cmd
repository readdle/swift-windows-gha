setlocal enabledelayedexpansion

rem *** Parse input arguments
:sw_parse_argument
set "CURRENT_ARG=%~1"
if not defined CURRENT_ARG goto sw_parse_argumens_end

if [%NEXT_ARG%]==[SW_SCOPE] goto sw_parse_argument_accept
if [%NEXT_ARG%]==[SW_NAME] goto sw_parse_argument_accept
if [%NEXT_ARG%]==[SW_FLAG] goto sw_parse_argument_accept

if [%CURRENT_ARG%]==[--scope] set NEXT_ARG=SW_SCOPE
if [%CURRENT_ARG%]==[--name] set NEXT_ARG=SW_NAME
if [%CURRENT_ARG%]==[--flag] set NEXT_ARG=SW_FLAG
if [%CURRENT_ARG%]==[--help] goto help

if not defined NEXT_ARG (
  call %SW_LOG_ERROR% --scope "step" --prefix "Unknown parameter:" --message "%CURRENT_ARG%"
  exit /b 1
)

goto :sw_parse_argument_next

:sw_parse_argument_accept
set "%NEXT_ARG%=%CURRENT_ARG%"
set NEXT_ARG=

:sw_parse_argument_next
shift
goto sw_parse_argument
:sw_parse_argumens_end


if "!%SW_FLAG%!"=="YES" (
  %SW_LOG_WARNING% --scope=%SW_SCOPE% --prefix="** " --message="Skipping: %SW_NAME%"
  exit /b 1
)
%SW_LOG_INFO% --scope=%SW_SCOPE% --prefix="** " --message="Starting step: %SW_NAME%"

endlocal
