set "SW_LOG_JOB_INFO=%SW_LOG_INFO% --scope bundle-sdk"
set "SW_LOG_JOB_ERROR=%SW_LOG_ERROR% --scope bundle-sdk"

%SW_LOG_JOB_INFO% --message="Configuring build environment..."

if not defined SW_SWIFT_REF (
  %SW_LOG_JOB_INFO% --message="swift ref not set, using default"
  call :sw_get_ref SW_SWIFT_REF
)

set "SW_SWIFT_SOURCES_DIR=%SW_SOURCES_DIR%\swift"

set "SW_BUNDLE_INSTALL_DIR=%SW_INSTALL_DIR%\bundle-sdk"
set "SW_PLATFORM_DIR=%SW_ARTIFACTS_DIR%\Library\Developer\Platforms\Windows.platform"
set "SW_SDK_DIR=%SW_PLATFORM_DIR%\Developer\SDKs\Windows.sdk"

%SW_LOG_JOB_INFO% --prefix="apple/swift:         " --message="%SW_SWIFT_REF%"
%SW_LOG_JOB_INFO% --prefix="apple/swift sources: " --message="%SW_SWIFT_SOURCES_DIR%"
%SW_LOG_JOB_INFO%
%SW_LOG_JOB_INFO% --prefix="Install dir:  " --message="%SW_BUNDLE_INSTALL_DIR%"
%SW_LOG_JOB_INFO%
%SW_LOG_JOB_INFO% --prefix="Platform dir: " --message="%SW_PLATFORM_DIR%"
%SW_LOG_JOB_INFO%

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
