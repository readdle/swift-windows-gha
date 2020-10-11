setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="devtools" --name="Checkout swift-package-manager" --flag=SW_SKIP_DEVTOOLS_CHECKOUT
if errorlevel 1 exit /b 0

call scripts\tools\checkout.cmd --url=git://github.com/apple/swift-package-manager --dir=%SW_SPM_SOURCES_DIR% --ref=%SW_SPM_REF% --depth=1

endlocal
