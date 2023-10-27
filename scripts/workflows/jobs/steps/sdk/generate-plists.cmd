setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="sdk" --name="Generate plists" --flag=SW_SKIP_SDK_PLISTS
if errorlevel 1 exit /b 0

set SW_LOG_STEP_INFO=%SW_LOG_INFO% --scope plist

set SW_INFO_PLIST=%SW_PLATFORM_DIR%\Info.plist
set SW_SDKSETTINGS_PLIST=%SW_SDK_DIR%\SDKSettings.plist

if exist %SW_INFO_PLIST% del %SW_INFO_PLIST%
if exist %SW_SDKSETTINGS_PLIST% del %SW_SDKSETTINGS_PLIST%

%SW_LOG_STEP_INFO% --message "-- %SW_INFO_PLIST%"
python.exe -c "import plistlib; print(str(plistlib.dumps({ 'DefaultProperties': { 'XCTEST_VERSION': 'development', 'SWIFTC_FLAGS': ['-use-ld=lld'] } }), encoding='utf-8'))" > %SW_INFO_PLIST%
if errorlevel 1 exit /b

%SW_LOG_STEP_INFO% --message "-- %SW_SDKSETTINGS_PLIST%"
python.exe -c "import plistlib; print(str(plistlib.dumps({ 'DefaultProperties': { 'DEFAULT_USE_RUNTIME': 'MD' } }), encoding='utf-8'))" > %SW_SDKSETTINGS_PLIST%
if errorlevel 1 exit /b

endlocal
