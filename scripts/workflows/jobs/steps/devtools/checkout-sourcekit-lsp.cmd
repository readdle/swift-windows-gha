setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="devtools" --name="Checkout sourcekit-lsp" --flag=SW_SKIP_DEVTOOLS_CHECKOUT
if errorlevel 1 exit /b 0

call scripts\tools\checkout.cmd --url=git://github.com/apple/sourcekit-lsp --dir=%SW_SOURCEKIT_SOURCES_DIR% --ref=%SW_SOURCEKIT_REF% --depth=1

endlocal
