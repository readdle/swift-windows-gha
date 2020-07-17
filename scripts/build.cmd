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
    exit /b 1
  )
)
if [%SWW_ACTIVE_ARG%] neq [] (
  echo Parameter value not specified: !SWW_ACTIVE_ARG!
  exit /b 1
)

if not exist %SW_CONFIG_FILE% (
    echo Configuration not found: %SW_CONFIG_FILE%
    exit /b 1
)

call scripts\tools\vs-env.cmd -arch=x64 -host_arch=x64

echo Using configuration from %SW_CONFIG_FILE%
call %SW_CONFIG_FILE%

echo.
echo Swift branch spec:       %SW_SWIFT_BRANCH_SPEC%
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
