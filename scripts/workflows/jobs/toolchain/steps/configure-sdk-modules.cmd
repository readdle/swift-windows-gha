copy %SW_SOURCES_PATH%\toolchain\swift\stdlib\public\Platform\ucrt.modulemap "%UniversalCRTSdkDir%\Include\%UCRTVersion%\ucrt\module.modulemap"
copy %SW_SOURCES_PATH%\toolchain\swift\stdlib\public\Platform\visualc.modulemap "%VCToolsInstallDir%\include\module.modulemap"
copy %SW_SOURCES_PATH%\toolchain\swift\stdlib\public\Platform\visualc.apinotes "%VCToolsInstallDir%\include\visualc.apinotes"
copy %SW_SOURCES_PATH%\toolchain\swift\stdlib\public\Platform\winsdk.modulemap "%UniversalCRTSdkDir%\Include\%UCRTVersion%\um\module.modulemap"
