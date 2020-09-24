setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="sdk" --name="Checkout Foundation" --flag=SW_SKIP_SDK_CHECKOUT
if errorlevel 1 exit /b 0

call scripts\tools\checkout.cmd --url=%SW_FOUNDATION_ORIGIN_URL% --dir=%SW_FOUNDATION_SOURCES_DIR% --ref=%SW_FOUNDATION_REF% --depth=1

endlocal
