set "SW_LOG_JOB_INFO=%SW_LOG_INFO% --scope icu-tools"
set "SW_LOG_JOB_WARNING=%SW_LOG_WARNING% --scope icu-tools"

%SW_LOG_JOB_INFO% --message="Configuring build environment"

set SW_ICU_REF=maint/maint-%SW_ICU_RELEASE%
@REM call :sw_get_ref SW_SWIFT_INSTALLER_SCRIPTS_REF
set SW_SWIFT_INSTALLER_SCRIPTS_REF=main

set "SW_ICU_SOURCES_DIR=%SW_SOURCES_DIR%\icu"
set "SW_SWIFT_INSTALLER_SCRIPTS_SOURCES_DIR=%SW_SOURCES_DIR%\swift-installer-scripts"
set "SW_ICU_TOOLS_BUILD_DIR=%SW_BUILD_DIR%\icu-tools-%SW_ICU_VERSION%"

%SW_LOG_JOB_INFO% --prefix="icu:                                       " --message="%SW_ICU_REF%"
%SW_LOG_JOB_INFO% --prefix="swift-installer-scripts:                   " --message="%SW_SWIFT_INSTALLER_SCRIPTS_REF%"
%SW_LOG_JOB_INFO%
%SW_LOG_JOB_INFO% --prefix="ICU sources directory:                     " --message="%SW_ICU_SOURCES_DIR%"
%SW_LOG_JOB_INFO% --prefix="swift-installer-scripts sources directory: " --message="%SW_SWIFT_INSTALLER_SCRIPTS_SOURCES_DIR%"
%SW_LOG_JOB_INFO%
%SW_LOG_JOB_INFO% --prefix="ICU tools build directory:                 " --message="%SW_ICU_TOOLS_BUILD_DIR%"

exit /b

rem ###########################################################################
:sw_get_ref <result_var> <prefix>
setlocal enabledelayedexpansion

set PREFIX=%2

if %SW_SWIFT_BRANCH_SPEC%==5.7 (
  set REF=%PREFIX%release/5.7
) else (
  set REF=%PREFIX%main
)

endlocal && set %1=%REF%
exit /b
