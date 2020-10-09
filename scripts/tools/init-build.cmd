:: Initializes global build environment

call :sw_normalize_path SW_WORKSPACE "%~dp0\..\.."

set SW_SET_ENV=call "%SW_WORKSPACE%\scripts\tools\set-env.cmd"
set SW_PRE_STEP=call "%SW_WORKSPACE%\scripts\tools\pre-step.cmd"
set SW_PRE_JOB=call "%SW_WORKSPACE%\scripts\tools\pre-job.cmd"

call "%SW_WORKSPACE%\scripts\tools\init-log.cmd"

exit /b 0



:: ###########################################################################
:sw_normalize_path <output_var> <path>
set "%1=%~f2"
exit /b
