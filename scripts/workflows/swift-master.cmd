@echo off

setlocal

set SW_WORKSPACE=%CD%
set SW_JOBS_DIR=%SW_WORKSPACE%\scripts\workflows\jobs
set SW_ICU_VERSION=64

call %SW_JOBS_DIR%\icu\icu.cmd

endlocal
