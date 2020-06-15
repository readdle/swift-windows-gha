call scripts\tools\vs-env.cmd -arch=x64 -host_arch=x64

call scripts\tools\set-env.cmd SW_XML2_REF cmake
call scripts\tools\set-env.cmd SW_XML2_SOURCES_DIR %SW_SOURCES_DIR%\libxml2
call scripts\tools\set-env.cmd SW_XML2_BUILD_DIR %SW_BUILD_DIR%\libxml2
call scripts\tools\set-env.cmd SW_XML2_INSTALL_DIR %SW_INSTALL_DIR%\Library\libxml2-%SW_XML2_VERSION%\usr
