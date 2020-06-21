@echo off

setlocal

for %%x in (%*) do (
  echo %%~x
)

set SWW_BRANCH_NUM_DEFAULT=1
set SWW_SOURCES_DIR_DEFAULT=%CD%\w\s
set SWW_BUILD_DIR_DEFAULT=%CD%\w\b
set SWW_INSATLL_DIR_DEFAULT=%CD%\w\i
set SWW_CONFIG_FILE_DEFAULT=%CD%\config.cmd
set SWW_SAVE_CONFIG_DEFAULT=Y

:wizard-start

echo Available branches:
echo.  1. master
echo.  2. 5.3
echo.  3. 5.2

:ask-branch
set /p SWW_BRANCH_NUM="Enter branch number to build (%SWW_BRANCH_NUM_DEFAULT%): "
if [%SWW_BRANCH_NUM%]==[] (
  set SWW_BRANCH_NUM=%SWW_BRANCH_NUM_DEFAULT%
)

if [%SWW_BRANCH_NUM%]==[1] (
  set SWW_SWIFT_BRANCH_SPEC=master
) else if [%SWW_BRANCH_NUM%]==[2] (
  set SWW_SWIFT_BRANCH_SPEC=5.3
) else if [%SWW_BRANCH_NUM%]==[3] (
  set SWW_SWIFT_BRANCH_SPEC=5.2
) else (
  goto ask-branch
)
set SWW_BRANCH_NUM_DEFAULT=%SWW_BRANCH_NUM%

set /p SWW_SOURCES_DIR="Enter directory for source files (%SWW_SOURCES_DIR_DEFAULT%): "
if [%SWW_SOURCES_DIR%]==[] (
  set SWW_SOURCES_DIR=%SWW_SOURCES_DIR_DEFAULT%
)
set SWW_SOURCES_DIR_DEFAULT=%SWW_SOURCES_DIR%

set /p SWW_BUILD_DIR="Enter directory for build output (%SWW_BUILD_DIR_DEFAULT%): "
if [%SWW_BUILD_DIR%]==[] (
  set SWW_BUILD_DIR=%SWW_BUILD_DIR_DEFAULT%
)
set SWW_BUILD_DIR_DEFAULT=%SWW_BUILD_DIR%

set /p SWW_INSATLL_DIR="Enter directory to install into (%SWW_INSATLL_DIR_DEFAULT%): "
if [%SWW_INSATLL_DIR%]==[] (
  set SWW_INSATLL_DIR=%SWW_INSATLL_DIR_DEFAULT%
)
set SWW_INSATLL_DIR_DEFAULT=%SWW_INSATLL_DIR%

set /p SWW_CONFIG_FILE="Enter configuration file name to save (%SWW_CONFIG_FILE_DEFAULT%): "
if [%SWW_CONFIG_FILE%]==[] (
  set SWW_CONFIG_FILE=%SWW_CONFIG_FILE_DEFAULT%
)
set SWW_CONFIG_FILE_DEFAULT=%SWW_CONFIG_FILE%

if [%SWW_SWIFT_BRANCH_SPEC%]==[5.2] (
  set SWW_ICU_VERSION=64
) else (
  set SWW_ICU_VERSION=67
)

set SWW_CURL_VERSION=development
set SWW_XML2_VERSION=development
set SWW_ZLIB_VERSION=1.2.11

echo.
echo Swift branch spec:      %SWW_SWIFT_BRANCH_SPEC%
echo Source files directory: %SWW_SOURCES_DIR%
echo Build output directory: %SWW_BUILD_DIR%
echo Install directory:      %SWW_INSATLL_DIR%
echo.
echo CURL version:           %SWW_CURL_VERSION%
echo ICU version:            %SWW_ICU_VERSION%
echo XML2 version:           %SWW_XML2_VERSION%
echo ZLIB version:           %SWW_ZLIB_VERSION%
echo.
echo Configuration file:     %SWW_CONFIG_FILE%
echo.

:ask-save
set /p SWW_SAVE_CONFIG="Do you want to save this configuration? (Y/n): "
if [%SWW_SAVE_CONFIG%]==[] (
  set SWW_SAVE_CONFIG=%SWW_SAVE_CONFIG_DEFAULT%
)
if /i [%SWW_SAVE_CONFIG%]==[Y] (
  echo set SW_SWIFT_BRANCH_SPEC=%SWW_SWIFT_BRANCH_SPEC%>%SWW_CONFIG_FILE%
  echo set SW_SOURCES_DIR=%SWW_SOURCES_DIR%>>%SWW_CONFIG_FILE%
  echo set SW_BUILD_DIR=%SWW_BUILD_DIR%>>%SWW_CONFIG_FILE%
  echo set SW_INSATLL_DIR=%SWW_INSATLL_DIR%>>%SWW_CONFIG_FILE%
  echo set SW_CURL_VERSION=%SWW_CURL_VERSION%>>%SWW_CONFIG_FILE%
  echo set SW_ICU_VERSION=%SWW_ICU_VERSION%>>%SWW_CONFIG_FILE%
  echo set SW_XML2_VERSION=%SWW_XML2_VERSION%>>%SWW_CONFIG_FILE%
  echo set SW_ZLIB_VERSION=%SWW_ZLIB_VERSION%>>%SWW_CONFIG_FILE%
) else if /i [%SWW_SAVE_CONFIG%]==[N] (
  echo.
  goto wizard-start
) else (
  goto ask-save
)

echo Configuration saved. Run build.cmd.

endlocal