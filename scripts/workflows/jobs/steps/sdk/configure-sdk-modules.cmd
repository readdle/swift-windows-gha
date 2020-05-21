copy %SW_SWIFT_SOURCES_DIR%\stdlib\public\Platform\ucrt.modulemap "%UniversalCRTSdkDir%\Include\%UCRTVersion%\ucrt\module.modulemap"
copy %SW_SWIFT_SOURCES_DIR%\stdlib\public\Platform\visualc.modulemap "%VCToolsInstallDir%\include\module.modulemap"
copy %SW_SWIFT_SOURCES_DIR%\stdlib\public\Platform\visualc.apinotes "%VCToolsInstallDir%\include\visualc.apinotes"
copy %SW_SWIFT_SOURCES_DIR%\stdlib\public\Platform\winsdk.modulemap "%UniversalCRTSdkDir%\Include\%UCRTVersion%\um\module.modulemap"
