call scripts\tools\vs-env.cmd -arch=x64 -host_arch=x64

call scripts\tools\set-env.cmd SW_ICU_REF maint/maint-%SW_ICU_VERSION%
call scripts\tools\set-env.cmd SW_ICU_SOURCES_DIR %SW_SOURCES_DIR%\icu
call scripts\tools\set-env.cmd SW_ICU_BUILD_DIR %SW_BUILD_DIR%\icu
call scripts\tools\set-env.cmd SW_ICU_INSTALL_DIR %SW_INSTALL_DIR%\Library\icu-%SW_ICU_VERSION%\usr

mkdir "%SW_ICU_SOURCES_DIR%\icu4c"
subst T: "%SW_ICU_SOURCES_DIR%\icu4c"
