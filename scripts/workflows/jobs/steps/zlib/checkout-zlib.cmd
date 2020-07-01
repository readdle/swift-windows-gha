setlocal

set SW_PUSHDIR=%CD%

git init %SW_ZLIB_SOURCES_DIR%^
 && cd /d %SW_ZLIB_SOURCES_DIR%^
 && (git remote add origin https://github.com/madler/zlib || ver>nul)^
 && git config gc.auto 0^
 && git fetch --no-tags --prune --progress --no-recurse-submodules --depth=1 origin +%SW_ZLIB_REF%*:%SW_ZLIB_REF%*^
 && git checkout --progress --force %SW_ZLIB_REF%^
 && git log -1

set SW_ERROR=%ERRORLEVEL%
cd /d %SW_PUSHDIR%

endlocal & exit /b %SW_ERROR%