setlocal

set SW_PUSHDIR=%CD%

git init %SW_XCTEST_SOURCES_DIR%^
 && cd /d %SW_XCTEST_SOURCES_DIR%^
 && (git remote add origin https://github.com/apple/swift-corelibs-xctest || ver>nul)^
 && git config --add core.autocrlf false^
 && git config --add core.symlinks true^
 && git config gc.auto 0^
 && git fetch --no-tags --prune --progress --no-recurse-submodules --depth=1 origin +refs/heads/%SW_XCTEST_REF%*:refs/remotes/origin/%SW_XCTEST_REF%* +refs/tags/%SW_XCTEST_REF%*:refs/tags/%SW_XCTEST_REF%*^
 && git branch --list --remote origin/%SW_XCTEST_REF%^
 && git checkout --progress --force -B %SW_XCTEST_REF% refs/remotes/origin/%SW_XCTEST_REF%^
 && git log -1

set SW_ERROR=%ERRORLEVEL%
cd /d %SW_PUSHDIR%

endlocal & exit /b %SW_ERROR%
