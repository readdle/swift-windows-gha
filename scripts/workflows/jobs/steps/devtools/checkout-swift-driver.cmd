setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="devtools" --name="Checkout swift-driver" --flag=SW_SKIP_DEVTOOLS_CHECKOUT
if errorlevel 1 exit /b 0

call scripts\tools\checkout.cmd --url=git://github.com/apple/swift-driver --dir=%SW_SWIFT_DRIVER_SOURCES_DIR% --ref=%SW_SWIFT_DRIVER_REF% --depth=1

endlocal
