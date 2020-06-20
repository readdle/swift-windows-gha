@echo off

setlocal

for %%x in (%*) do (
  echo %%~x
)

rem set /p id="Enter ID: "

echo Available branches:
echo.  1. master
echo.  2. 5.3
echo.  3. 5.2

:ask-branch
set /p SWW_BRANCH_NUM="Enter branch number to build (1): "
if [%SWW_BRANCH_NUM%]==[] (
  set SW_SWIFT_BRANCH_SPEC=master
) else if [%SWW_BRANCH_NUM%]==[1] (
  set SW_SWIFT_BRANCH_SPEC=master
) else if [%SWW_BRANCH_NUM%]==[2] (
  set SW_SWIFT_BRANCH_SPEC=5.3
) else if [%SWW_BRANCH_NUM%]==[3] (
  set SW_SWIFT_BRANCH_SPEC=5.2
) else (
  goto ask-branch
)

set SWW_SOURCES_DIR_DEFAULT=%CD%\w\s
set /p SWW_SOURCES_DIR="Enter directory for source files (%SWW_SOURCES_DIR_DEFAULT%): "
if [%SWW_SOURCES_DIR%]==[] (
  set SWW_SOURCES_DIR=%SWW_SOURCES_DIR_DEFAULT%
)

set SWW_BUILD_DIR_DEFAULT=%CD%\w\b
set /p SWW_BUILD_DIR="Enter directory for build output (%SWW_BUILD_DIR_DEFAULT%): "
if [%SWW_BUILD_DIR%]==[] (
  set SWW_BUILD_DIR=%SWW_BUILD_DIR_DEFAULT%
)

set SWW_INSATLL_DIR_DEFAULT=%CD%\w\i
set /p SWW_INSATLL_DIR="Enter directory to install into (%SWW_INSATLL_DIR_DEFAULT%): "
if [%SWW_INSATLL_DIR%]==[] (
  set SWW_INSATLL_DIR=%SWW_INSATLL_DIR_DEFAULT%
)

set SWW_CONFIG_FILE_DEFAULT=%CD%\config.cmd
set /p SWW_CONFIG_FILE="Enter configuration file name to save(%SWW_CONFIG_FILE_DEFAULT%): "
if [%SWW_CONFIG_FILE%]==[] (
  set SWW_CONFIG_FILE=%SWW_CONFIG_FILE_DEFAULT%
)

echo.
echo Swift branch spec:      %SW_SWIFT_BRANCH_SPEC%
echo Source files directory: %SWW_SOURCES_DIR%
echo Build output directory: %SWW_BUILD_DIR%
echo Install directory:      %SWW_INSATLL_DIR%

endlocal