call scripts\tools\vs-env.cmd -arch=x64 -host_arch=x64

call scripts\tools\set-env.cmd SW_ICU_REF maint/maint-%SW_ICU_VERSION%
call scripts\tools\set-env.cmd SW_ICU_SOURCES_DIR %SW_SOURCES_DIR%\icu
call scripts\tools\set-env.cmd SW_ICU_BUILD_DIR %SW_BUILD_DIR%\icu
call scripts\tools\set-env.cmd SW_ICU_INSTALL_DIR %SW_INSTALL_DIR%\Library\icu-%SW_ICU_VERSION%\usr

%SW_LOG_ICU_INFO% --prefix="Git ref:           " --message="%SW_ICU_REF%"
%SW_LOG_ICU_INFO% --prefix="Sources directory: " --message="%SW_ICU_SOURCES_DIR%"
%SW_LOG_ICU_INFO% --prefix="Build directory:   " --message="%SW_ICU_BUILD_DIR%"
%SW_LOG_ICU_INFO% --prefix="Install directory: " --message="%SW_ICU_INSTALL_DIR%"

mkdir "%SW_ICU_SOURCES_DIR%"
subst T: "%SW_ICU_SOURCES_DIR%"
