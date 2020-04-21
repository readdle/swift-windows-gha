@echo off

setlocal

set SW_WORKSPACE=%CD%
set SW_SOURCES_DIR=%SW_WORKSPACE%\src
set SW_BUILD_DIR=%SW_WORKSPACE%\build
set SW_INSTALL_DIR=%SW_WORKSPACE%\install

set SW_JOBS_DIR=%SW_WORKSPACE%\scripts\workflows\jobs
set SW_ICU_VERSION=64

call %SW_JOBS_DIR%\icu.cmd

endlocal
