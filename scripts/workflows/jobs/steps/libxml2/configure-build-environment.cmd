set SW_XML2_REF=cmake
set SW_XML2_SOURCES_DIR=%SW_SOURCES_DIR%\libxml2
set SW_XML2_BUILD_DIR=%SW_BUILD_DIR%\libxml2
set SW_XML2_INSTALL_DIR=%SW_INSTALL_DIR%\Library\libxml2-%SW_XML2_VERSION%\usr

if not defined VSCMD_VER call scripts\tools\vsenv.cmd -arch=x64 -host_arch=x64
if not defined GITHUB_ACTION goto :eof

echo ::set-env name=SW_XML2_REF::%SW_XML2_REF%
echo ::set-env name=SW_XML2_SOURCES_DIR::%SW_XML2_SOURCES_DIR%
echo ::set-env name=SW_XML2_BUILD_DIR::%SW_XML2_BUILD_DIR%
echo ::set-env name=SW_XML2_INSTALL_DIR::%SW_XML2_INSTALL_DIR%
