setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="sdk" --name="Generate plists" --flag=SW_SKIP_SDK_PLISTS
if errorlevel 1 exit /b 0

set SW_INFO_PLIST=%SW_PLATFORM_DIR%\Info.plist
set SW_SDKSETTINGS_PLIST=%SW_SDK_DIR%\SDKSettings.plist

if exist %SW_INFO_PLIST% del %SW_INFO_PLIST%
if exist %SW_SDKSETTINGS_PLIST% del %SW_SDKSETTINGS_PLIST%

%SW_PLUTIL% insert DefaultProperties xml "'<dict><key>SWIFTC_FLAGS</key><array><string>-use-ld=lld</string></array><key>XCTEST_VERSION</key><string>development</string></dict>'" %SW_INFO_PLIST%
%SW_PLUTIL% insert DefaultProperties xml "'<dict><key>DEFAULT_USE_RUNTIME</key><string>MD</string></dict>'" %SW_SDKSETTINGS_PLIST%

endlocal
