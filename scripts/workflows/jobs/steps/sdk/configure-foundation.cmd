setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="sdk" --name="Configure Foundation" --flag=SW_SKIP_SDK_FOUNDATION
if errorlevel 1 exit /b 0

cmake^
 -G Ninja^
 -S %SW_FOUNDATION_SOURCES_DIR%^
 -B %SW_FOUNDATION_BUILD_DIR%^
 -C %SW_WORKSPACE%\cmake\caches\windows-x86_64-clang.cmake^
 -D SWIFT_STDLIB_DIR=%SW_STDLIB_BUILD_DIR%^
 -C %SW_WORKSPACE%\cmake\caches\windows-x86_64-swift-flags.cmake^
 -D CMAKE_ASM_COMPILE_OPTIONS_MSVC_RUNTIME_LIBRARY_MultiThreadedDLL="/MD"^
 -D CMAKE_BUILD_TYPE=Release^
 -D CMAKE_INSTALL_PREFIX=%SW_SDK_INSTALL_DIR%^
 -D ZLIB_LIBRARY=%SW_ZLIB_DIR%\usr\lib\zlibstatic.lib^
 -D ZLIB_INCLUDE_DIR=%SW_ZLIB_DIR%\usr\include^
 -D CURL_LIBRARY=%SW_CURL_DIR%\usr\lib\libcurl.lib^
 -D CURL_INCLUDE_DIR=%SW_CURL_DIR%\usr\include^
 -D ICU_INCLUDE_DIR=%SW_ICU_DIR%\usr\include^
 -D ICU_UC_LIBRARY=%SW_ICU_DIR%\usr\lib\icuuc%SW_ICU_VERSION%.lib^
 -D ICU_UC_LIBRARY_RELEASE=%SW_ICU_DIR%/usr/lib/icuuc%SW_ICU_VERSION%.lib^
 -D ICU_I18N_LIBRARY=%SW_ICU_DIR%/usr/lib/icuin%SW_ICU_VERSION%.lib^
 -D ICU_I18N_LIBRARY_RELEASE=%SW_ICU_DIR%/usr/lib/icuin%SW_ICU_VERSION%.lib^
 -D LIBXML2_LIBRARY=%SW_XML2_DIR%\usr\lib\libxml2s.lib^
 -D LIBXML2_INCLUDE_DIR=%SW_XML2_DIR%\usr\include\libxml2^
 -D dispatch_DIR=%SW_DISPATCH_BUILD_DIR%\cmake\modules^
 -D CURL_NO_CURL_CMAKE=YES^
 -D CURL_DIR=%SW_CURL_DIR%\usr\lib\cmake\CURL^
 -D ENABLE_TESTING=NO

endlocal
