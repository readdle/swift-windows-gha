if defined SW_LOG_INITIALIZED exit /b

for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set SW_ESC=%%b
)

set SW_LOG_RESET=%SW_ESC%[0m

set SW_LOG_BOLD=%SW_ESC%[1m
set SW_LOG_RED=%SW_ESC%[31m
set SW_LOG_GREEN=%SW_ESC%[32m
set SW_LOG_YELLOW=%SW_ESC%[33m
set SW_LOG_MAGENTA=%SW_ESC%[35m

set SW_LOG=call "%~f0\..\log.cmd"
set SW_LOG_INFO=%SW_LOG% --level info
set SW_LOG_ERROR=%SW_LOG% --level error
set SW_LOG_WARNING=%SW_LOG% --level warning

set SW_LOG_INITIALIZED=Y
