set SW_ICU_REF=maint/maint-%SW_ICU_VERSION%
set SW_ICU_SOURCES_DIR=%SW_SOURCES_DIR%\icu
set SW_ICU_BUILD_DIR=%SW_BUILD_DIR%\icu
set SW_ICU_INSTALL_DIR=%SW_INSTALL_DIR%\Library\icu-%SW_ICU_VERSION%\usr

mkdir "%SW_ICU_SOURCES_DIR%\icu4c"
subst T: "%SW_ICU_SOURCES_DIR%\icu4c"
if errorlevel 1 goto :eof

if not defined VSCMD_VER call scripts\tools\vs-env.cmd -arch=x64 -host_arch=x64
if not defined GITHUB_ACTION goto :eof

echo ::set-env name=SW_ICU_REF::%SW_ICU_REF%
echo ::set-env name=SW_ICU_SOURCES_DIR::%SW_ICU_SOURCES_DIR%
echo ::set-env name=SW_ICU_BUILD_DIR::%SW_ICU_BUILD_DIR%
echo ::set-env name=SW_ICU_INSTALL_DIR::%SW_ICU_INSTALL_DIR%
