setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="devtools" --name="Checkout indexstore-db" --flag=SW_SKIP_DEVTOOLS_CHECKOUT
if errorlevel 1 exit /b 0

call scripts\tools\checkout.cmd --url=git://github.com/apple/indexstore-db --dir=%SW_INDEXSTORE_DB_SOURCES_DIR% --ref=%SW_INDEXSTORE_DB_REF% --depth=1

endlocal
