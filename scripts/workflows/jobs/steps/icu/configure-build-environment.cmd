%SW_SET_ENV% SW_LOG_ICU_INFO "%SW_LOG_INFO% --scope icu"
%SW_SET_ENV% SW_LOG_ICU_WARNING "%SW_LOG_WARNING% --scope icu"

%SW_LOG_ICU_INFO% --message="Configuring build environment"

call "%SW_WORKSPACE%\scripts\tools\get-free-drive.cmd"

%SW_SET_ENV% SW_ICU_REF maint/maint-%SW_ICU_VERSION%
%SW_SET_ENV% SW_ICU_SOURCES_DIR %SW_SOURCES_DIR%\icu
%SW_SET_ENV% SW_ICU_BUILD_DIR %SW_BUILD_DIR%\icu
%SW_SET_ENV% SW_ICU_INSTALL_DIR %SW_INSTALL_DIR%\Library\icu-%SW_ICU_VERSION%\usr
%SW_SET_ENV% SW_ICU_DRIVE %SW_FREE_DRIVE%

%SW_LOG_ICU_INFO% --prefix="Git ref:           " --message="%SW_ICU_REF%"
%SW_LOG_ICU_INFO% --prefix="Sources directory: " --message="%SW_ICU_SOURCES_DIR%"
%SW_LOG_ICU_INFO% --prefix="Build directory:   " --message="%SW_ICU_BUILD_DIR%"
%SW_LOG_ICU_INFO% --prefix="Install directory: " --message="%SW_ICU_INSTALL_DIR%"

mkdir "%SW_ICU_SOURCES_DIR%"
subst %SW_ICU_DRIVE% %SW_ICU_SOURCES_DIR%
subst
