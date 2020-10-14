setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="devtools" --name="Self-host swift-package-manager" --flag=SW_SKIP_DEVTOOLS_SPM
if errorlevel 1 exit /b 0

pushd %SW_SPM_SOURCES_DIR%

swift-build^
 --verbose^
 -Xmanifest -sdk^
 -Xmanifest %SW_SDK_DIR%^
 -Xmanifest -I%SW_SDK_DIR%\usr\lib\swift^
 -Xmanifest -I%SW_SDK_DIR%\usr\lib\swift\windows^
 -Xmanifest -L%SW_SDK_DIR%\usr\lib\swift\windows^
 -Xswiftc -sdk^
 -Xswiftc %SW_SDK_DIR%^
 -Xswiftc -I%SW_SDK_DIR%\usr\lib\swift^
 -Xswiftc -I%SW_SDK_DIR%\usr\lib\swift\windows^
 -Xswiftc -L%SW_SDK_DIR%\usr\lib\swift\windows^
 -Xswiftc -I%SW_DEVELOPER_LIBRARY_DIR%\XCTest-development\usr\lib\swift\windows\x86_64^
 -Xswiftc -L%SW_DEVELOPER_LIBRARY_DIR%\XCTest-development\usr\lib\swift\windows^
 -Xcc -I%SW_SQLITE_DIR%\usr\include^
 -Xswiftc -L%SW_SQLITE_DIR%\usr\lib^
 -Xswiftc -libc^
 -Xswiftc MD^
 -Xcc -Xclang^
 -Xcc --dependent-lib=msvcrt^
 -Xcc -D_MT^
 -Xcc -D_DLL^
 -Xlinker /INCREMENTAL:NO

popd

exit /b 0
endlocal
