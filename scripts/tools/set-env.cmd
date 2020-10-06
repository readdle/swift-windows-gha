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

set "%1=%~2"

:: Build script has global environment and needs no special handling of environment variables
if "%SW_BUILD_ENVIRONMENT%"=="script" goto :eof

:: No sense to try GitHub Actions Workflow command when running outside of Github Actions
if not defined GITHUB_ACTIONS goto :eof

echo ::set-env name=%1::%~2
