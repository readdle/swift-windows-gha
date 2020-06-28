setlocal

set SW_PUSHDIR=%CD%

git init %SW_CURL_SOURCES_DIR%^
 && cd /d %SW_CURL_SOURCES_DIR%^
 && (git remote add origin https://github.com/curl/curl.git || ver>nul)^
 && git fetch --no-tags --prune --progress --no-recurse-submodules --depth=1 origin +refs/heads/%SW_CURL_REF%*:refs/remotes/origin/%SW_CURL_REF%* +refs/tags/%SW_CURL_REF%*:refs/tags/%SW_CURL_REF%*^
 && git branch --list --remote origin/%SW_CURL_REF%^
 && git checkout --progress --force -B %SW_CURL_REF% refs/remotes/origin/%SW_CURL_REF%^
 && git log -1

set SW_ERROR=%ERRORLEVEL%
cd /d %SW_PUSHDIR%

endlocal & exit /b %SW_ERROR%
