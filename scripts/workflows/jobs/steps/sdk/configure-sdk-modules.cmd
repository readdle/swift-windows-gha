del "%UniversalCRTSdkDir%\Include\%UCRTVersion%\ucrt\module.modulemap"
del "%VCToolsInstallDir%\include\module.modulemap"
del "%VCToolsInstallDir%\include\visualc.apinotes"
del "%UniversalCRTSdkDir%\Include\%UCRTVersion%\um\module.modulemap"

copy /y %SW_SWIFT_SOURCES_DIR%\stdlib\public\Platform\ucrt.modulemap "%UniversalCRTSdkDir%\Include\%UCRTVersion%\ucrt\module.modulemap"^
 && copy /y %SW_SWIFT_SOURCES_DIR%\stdlib\public\Platform\visualc.modulemap "%VCToolsInstallDir%\include\module.modulemap"^
 && copy /y %SW_SWIFT_SOURCES_DIR%\stdlib\public\Platform\visualc.apinotes "%VCToolsInstallDir%\include\visualc.apinotes"^
 && copy /y %SW_SWIFT_SOURCES_DIR%\stdlib\public\Platform\winsdk.modulemap "%UniversalCRTSdkDir%\Include\%UCRTVersion%\um\module.modulemap"

if errorlevel 1 (
    echo Failed to install clang modules for Visual Studio. Make sure you have Administrator access.
    exit /b 1
)
