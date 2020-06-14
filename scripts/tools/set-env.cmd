@echo off

if [%1] == [] (
  echo Sets environment variables.
  echo.
  echo set-env.cmd name value
  echo.
  echo.    name     Specifies the environment-variable name.
  echo.    value    Specifies the environment-variable value.
  echo.

  goto :eof
)

set %1=%~2

if not defined GITHUB_ACTION goto :eof

echo ::set-env name=%1::%~2
