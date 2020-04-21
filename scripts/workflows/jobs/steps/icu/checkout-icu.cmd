setlocal

pushd %CD%

git init %SW_ICU_SOURCES_DIR%^
 && cd %SW_ICU_SOURCES_DIR%^
 && (git remote add origin https://github.com/unicode-org/icu || ver>nul)^
 && git fetch --no-tags --prune --progress --no-recurse-submodules --depth=1 origin +refs/heads/%SW_ICU_REF%*:refs/remotes/origin/%SW_ICU_REF%* +refs/tags/%SW_ICU_REF%*:refs/tags/%SW_ICU_REF%*^
 && git branch --list --remote origin/%SW_ICU_REF%^
 && git checkout --progress --force -B %SW_ICU_REF% refs/remotes/origin/%SW_ICU_REF%^
 && git log -1

set SW_ERROR=%ERRORLEVEL%
popd

:end
endlocal & exit /b %SW_ERROR%
