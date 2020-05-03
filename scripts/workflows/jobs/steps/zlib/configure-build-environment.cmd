set SW_ZLIB_REF=refs/tags/v%SW_ZLIB_VERSION%
set SW_ZLIB_SOURCES_DIR=%SW_SOURCES_DIR%\zlib
set SW_ZLIB_BUILD_DIR=%SW_BUILD_DIR%\zlib
set SW_ZLIB_INSTALL_DIR=%SW_INSTALL_DIR%\Library\zlib-%SW_ZLIB_VERSION%\usr

if not defined VSCMD_VER call scripts\tools\vsenv.cmd -arch=x64 -host_arch=x64
if not defined GITHUB_ACTION goto :eof

echo ::set-env name=SW_ZLIB_REF::%SW_ZLIB_REF%          
echo ::set-env name=SW_ZLIB_SOURCES_DIR::%SW_ZLIB_SOURCES_DIR%
echo ::set-env name=SW_ZLIB_BUILD_DIR::%SW_ZLIB_BUILD_DIR%
echo ::set-env name=SW_ZLIB_INSTALL_DIR::%SW_ZLIB_INSTALL_DIR%
