setlocal

pushd %CD%

git init %SW_FOUNDATION_SOURCES_DIR%^
 && cd %SW_FOUNDATION_SOURCES_DIR%^
 && git config --add core.autocrlf false^
 && git config --add core.symlinks true^
 && (git remote add origin https://github.com/apple/swift-corelibs-foundation || ver>nul)^
 && git fetch --no-tags --prune --progress --no-recurse-submodules --depth=1 origin +refs/heads/%SW_FOUNDATION_REF%*:refs/remotes/origin/%SW_FOUNDATION_REF%* +refs/tags/%SW_FOUNDATION_REF%*:refs/tags/%SW_FOUNDATION_REF%*^
 && git branch --list --remote origin/%SW_FOUNDATION_REF%^
 && git checkout --progress --force -B %SW_FOUNDATION_REF% refs/remotes/origin/%SW_FOUNDATION_REF%^
 && git log -1

set SW_ERROR=%ERRORLEVEL%
popd

endlocal & exit /b %SW_ERROR%
