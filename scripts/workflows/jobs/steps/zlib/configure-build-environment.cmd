call scripts\tools\vs-env.cmd -arch=x64 -host_arch=x64

call scripts\tools\set-env.cmd SW_ZLIB_REF refs/tags/v%SW_ZLIB_VERSION%
call scripts\tools\set-env.cmd SW_ZLIB_SOURCES_DIR %SW_SOURCES_DIR%\zlib
call scripts\tools\set-env.cmd SW_ZLIB_BUILD_DIR %SW_BUILD_DIR%\zlib
call scripts\tools\set-env.cmd SW_ZLIB_INSTALL_DIR %SW_INSTALL_DIR%\Library\zlib-%SW_ZLIB_VERSION%\usr
