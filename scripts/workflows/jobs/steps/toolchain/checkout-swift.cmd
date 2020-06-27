setlocal

set SW_PUSHDIR=%CD%

git init %SW_SWIFT_SOURCES_DIR%^
 && cd /d %SW_SWIFT_SOURCES_DIR%^
 && git config --add core.autocrlf false^
 && git config --add core.symlinks true^
 && (git remote add origin https://github.com/apple/swift || ver>nul)^
 && git fetch --no-tags --prune --progress --no-recurse-submodules --depth=1 origin +refs/heads/%SW_SWIFT_REF%*:refs/remotes/origin/%SW_SWIFT_REF%* +refs/tags/%SW_SWIFT_REF%*:refs/tags/%SW_SWIFT_REF%*^
 && git branch --list --remote origin/%SW_SWIFT_REF%^
 && git checkout --progress --force -B %SW_SWIFT_REF% refs/remotes/origin/%SW_SWIFT_REF%^
 && git log -1

set SW_ERROR=%ERRORLEVEL%
cd /d %SW_PUSHDIR%

endlocal & exit /b %SW_ERROR%