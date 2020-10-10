setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="devtools" --name="Checkout swift-llbuild" --flag=SW_SKIP_DEVTOOLS_CHECKOUT
if errorlevel 1 exit /b 0

call scripts\tools\checkout.cmd --url=git://github.com/apple/swift-llbuild --dir=%SW_LLBUILD_SOURCES_DIR% --ref=%SW_LLBUILD_REF% --depth=1

endlocal
