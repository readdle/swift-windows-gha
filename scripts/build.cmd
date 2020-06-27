@echo off

setlocal enabledelayedexpansion

set SW_CONFIG_FILE=config.cmd

for %%x in (%*) do (
  set SWW_CURRENT_ARG=%%~x
  if /i [!SWW_ACTIVE_ARG!]==[--config] (
    set SW_CONFIG_FILE=!SWW_CURRENT_ARG!
    set SWW_ACTIVE_ARG=
  ) else if /i [!SWW_CURRENT_ARG!]==[--config] (
    set SWW_ACTIVE_ARG=!SWW_CURRENT_ARG!
  ) else (
    echo Unknown parameter: !SWW_CURRENT_ARG!
    goto :eof
  )
)
if [%SWW_ACTIVE_ARG%] neq [] (
  echo Parameter value not specified: !SWW_ACTIVE_ARG!
  goto :eof
)

if not exist %SW_CONFIG_FILE% (
    echo Configuration not found: %SW_CONFIG_FILE%
    goto :eof
)

call scripts\tools\vs-env.cmd -arch=x64 -host_arch=x64

echo Using configuration from %SW_CONFIG_FILE%
call %SW_CONFIG_FILE%

echo.
echo Swift branch spec:      %SWW_SWIFT_BRANCH_SPEC%
echo Source files directory: %SWW_SOURCES_DIR%
echo Build output directory: %SWW_BUILD_DIR%
echo Install directory:      %SWW_INSTALL_DIR%
echo.
echo CURL version:           %SWW_CURL_VERSION%
echo ICU version:            %SWW_ICU_VERSION%
echo XML2 version:           %SWW_XML2_VERSION%
echo ZLIB version:           %SWW_ZLIB_VERSION%
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
 
call %SW_JOBS_DIR%\sdk.cmd

endlocal
