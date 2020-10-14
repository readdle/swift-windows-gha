setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="devtools" --name="Checkout swift-tools-support-core" --flag=SW_SKIP_DEVTOOLS_CHECKOUT
if errorlevel 1 exit /b 0

call scripts\tools\checkout.cmd --url=git://github.com/apple/swift-tools-support-core --dir=%SW_TSC_SOURCES_DIR% --ref=%SW_TSC_REF% --depth=1

endlocal
