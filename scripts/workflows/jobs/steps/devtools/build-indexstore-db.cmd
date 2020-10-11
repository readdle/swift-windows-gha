setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="devtools" --name="Build indexstore-db" --flag=SW_SKIP_DEVTOOLS_INDEXSTORE_DB
if errorlevel 1 exit /b 0

cmake --build %SW_INDEXSTORE_DB_BUILD_DIR%

endlocal
