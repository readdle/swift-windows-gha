setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="devtools" --name="Checkout swift-argument-parser" --flag=SW_SKIP_DEVTOOLS_CHECKOUT
if errorlevel 1 exit /b 0

call scripts\tools\checkout.cmd --url=git://github.com/apple/swift-argument-parser --dir=%SW_SAP_SOURCES_DIR% --ref=%SW_SAP_REF% --depth=1

endlocal
