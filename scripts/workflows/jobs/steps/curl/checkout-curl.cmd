setlocal

pushd %CD%

git init %SW_CURL_SOURCES_DIR%^
 && cd %SW_CURL_SOURCES_DIR%^
 && (git remote add origin https://github.com/curl/curl.git || ver>nul)^
 && git fetch --no-tags --prune --progress --no-recurse-submodules --depth=1 origin +%SW_CURL_REF%*:%SW_CURL_REF%*^
 && git checkout --progress --force %SW_CURL_REF%^
 && git log -1

set SW_ERROR=%ERRORLEVEL%
popd

endlocal & exit /b %SW_ERROR%
