set "SW_LOG_JOB_INFO=%SW_LOG_INFO% --scope bundle-toolchain"
set "SW_LOG_JOB_ERROR=%SW_LOG_ERROR% --scope bundle-toolchain"

%SW_LOG_JOB_INFO% --message="Configuring build environment..."

set "SW_BUNDLE_INSTALL_DIR=%SW_INSTALL_DIR%\bundle-toolchain"
set "SW_TOOLCHAIN_DIR=%SW_ARTIFACTS_DIR%\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain"

%SW_LOG_JOB_INFO% --prefix="Install dir:         " --message="%SW_BUNDLE_INSTALL_DIR%"
%SW_LOG_JOB_INFO%
%SW_LOG_JOB_INFO% --prefix="Toolchain dir:       " --message="%SW_TOOLCHAIN_DIR%"
%SW_LOG_JOB_INFO%
