setlocal enabledelayedexpansion

%SW_LOG_SQLITE_INFO% --prefix="Starting step: " --message="Download SQLite"

set SW_TARGET_FILE=%SW_SOURCES_DIR%\sqlite-amalgamation-%SW_SQLITE_RELEASE%.zip

if exist %SW_TARGET_FILE% (
   %SW_LOG_SQLITE_INFO% --message="Removing existing file"
   del %SW_TARGET_FILE%
)
%SW_LOG_SQLITE_INFO% --message="Downloading to %SW_TARGET_FILE%"

curl.exe --url %SW_SQLITE_URL% --output %SW_TARGET_FILE%
if errorlevel 1 goto :eof

set SW_PUSHDIR=%CD%
cd %SW_SOURCES_DIR%

%SW_LOG_SQLITE_INFO% --message="Extracting sources"

tar.exe -xf %SW_SOURCES_DIR%\sqlite-amalgamation-%SW_SQLITE_RELEASE%.zip
set SW_ERROR=%ERRORLEVEL%

cd /d %SW_PUSHDIR%

endlocal && exit /b %SW_ERROR%
