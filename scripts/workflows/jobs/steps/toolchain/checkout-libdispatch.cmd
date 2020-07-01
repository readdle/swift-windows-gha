setlocal

set SW_PUSHDIR=%CD%

git init %SW_DISPATCH_SOURCES_DIR%^
 && cd /d %SW_DISPATCH_SOURCES_DIR%^
 && (git remote add origin https://github.com/apple/swift-corelibs-libdispatch || ver>nul)^
 && git config --add core.autocrlf false^
 && git config --add core.symlinks true^
 && git config gc.auto 0^
 && git fetch --no-tags --prune --progress --no-recurse-submodules --depth=1 origin +refs/heads/%SW_DISPATCH_REF%*:refs/remotes/origin/%SW_DISPATCH_REF%* +refs/tags/%SW_DISPATCH_REF%*:refs/tags/%SW_DISPATCH_REF%*^
 && git branch --list --remote origin/%SW_DISPATCH_REF%^
 && git checkout --progress --force -B %SW_DISPATCH_REF% refs/remotes/origin/%SW_DISPATCH_REF%^
 && git log -1

set SW_ERROR=%ERRORLEVEL%
cd /d %SW_PUSHDIR%

endlocal & exit /b %SW_ERROR%
