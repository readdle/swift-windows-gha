set "SW_LOG_JOB_INFO=%SW_LOG_INFO% --scope libxml2"

%SW_LOG_JOB_INFO% --message="Configuring build environment..."

if "%SW_XML2_VERSION%"=="development" (
  set SW_XML2_REF=master
) else (
  set SW_XML2_REF=refs/tags/v%SW_XML2_VERSION%
)

set "SW_XML2_SOURCES_DIR=%SW_SOURCES_DIR%\libxml2"
set "SW_XML2_BUILD_DIR=%SW_BUILD_DIR%\libxml2-%SW_XML2_VERSION%"
set "SW_XML2_INSTALL_DIR=%SW_INSTALL_DIR%\Library\libxml2-%SW_XML2_VERSION%\usr"

%SW_LOG_JOB_INFO% --prefix="Git ref:           " --message="%SW_XML2_REF%"
%SW_LOG_JOB_INFO% --prefix="Sources directory: " --message="%SW_XML2_SOURCES_DIR%"
%SW_LOG_JOB_INFO% --prefix="Build directory:   " --message="%SW_XML2_BUILD_DIR%"
%SW_LOG_JOB_INFO% --prefix="Install directory: " --message="%SW_XML2_INSTALL_DIR%"
