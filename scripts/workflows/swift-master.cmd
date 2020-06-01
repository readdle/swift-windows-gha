@echo off

setlocal

call scripts\tools\vsenv.cmd -arch=x64 -host_arch=x64

set SW_WORKSPACE=%CD%

if defined GITHUB_ACTION (
  set SW_SOURCES_DIR=%SW_WORKSPACE%\..\s
  set SW_BUILD_DIR=%SW_WORKSPACE%\..\b
  set SW_INSTALL_DIR=%SW_WORKSPACE%\..\i
) else (
  set SW_SOURCES_DIR=%SW_WORKSPACE%\src
  set SW_BUILD_DIR=%SW_WORKSPACE%\build
  set SW_INSTALL_DIR=%SW_WORKSPACE%\install
)

set SW_ARTIFACTS_DIR=%SW_INSTALL_DIR%

set SW_JOBS_DIR=%SW_WORKSPACE%\scripts\workflows\jobs
set SW_CURL_VERSION=development
set SW_ICU_VERSION=67
set SW_XML2_VERSION=development
set SW_ZLIB_VERSION=1.2.11
set SW_SWIFT_BRANCH_SPEC=master

set SW_IGNORE_TEST_FAILURES=1

call %SW_JOBS_DIR%\icu.cmd^
 && call %SW_JOBS_DIR%\toolchain.cmd^
 && call %SW_JOBS_DIR%\zlib.cmd^
 && call %SW_JOBS_DIR%\libxml2.cmd^
 && call %SW_JOBS_DIR%\curl.cmd^
 && call %SW_JOBS_DIR%\sdk.cmd
 
endlocal
