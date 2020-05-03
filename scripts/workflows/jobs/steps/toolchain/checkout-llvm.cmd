setlocal

pushd %CD%

git init %SW_LLVM_SOURCES_DIR%^
 && cd %SW_LLVM_SOURCES_DIR%^
 && git config --add core.autocrlf false^
 && git config --add core.symlinks true^
 && (git remote add origin https://github.com/apple/llvm-project || ver>nul)^
 && git fetch --no-tags --prune --progress --no-recurse-submodules --depth=1 origin +refs/heads/%SW_LLVM_REF%*:refs/remotes/origin/%SW_LLVM_REF%* +refs/tags/%SW_LLVM_REF%*:refs/tags/%SW_LLVM_REF%*^
 && git branch --list --remote origin/%SW_LLVM_REF%^
 && git checkout --progress --force -B %SW_LLVM_REF% refs/remotes/origin/%SW_LLVM_REF%^
 && git log -1

set SW_ERROR=%ERRORLEVEL%
popd

endlocal & exit /b %SW_ERROR%
