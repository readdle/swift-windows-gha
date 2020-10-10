setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="devtools" --name="Checkout Yams" --flag=SW_SKIP_DEVTOOLS_CHECKOUT
if errorlevel 1 exit /b 0

call scripts\tools\checkout.cmd --url=git://github.com/jpsim/Yams --dir=%SW_YAMS_SOURCES_DIR% --ref=%SW_YAMS_REF% --depth=1

endlocal
