setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="sdk" --name="Checkout XCTest" --flag=SW_SKIP_SDK_CHECKOUT
if errorlevel 1 exit /b 0

call scripts\tools\checkout.cmd --url=git://github.com/apple/swift-corelibs-xctest --dir=%SW_XCTEST_SOURCES_DIR% --ref=%SW_XCTEST_REF% --depth=1

endlocal
