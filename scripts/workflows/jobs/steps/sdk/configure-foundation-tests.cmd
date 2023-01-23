setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="sdk" --name="Configure Foundation Tests" --flag=SW_SKIP_SDK_FOUNDATION_TEST
if errorlevel 1 exit /b 0

FOR /F "tokens=* USEBACKQ" %%i IN (`cygpath -m "%SW_TOOLCHAIN_DIR%"`) DO (
  SET SW_TOOLCHAIN_DIR=%%i
)

if "%SW_SWIFT_SDK_SPEC%"=="readdle" (
  set SW_ICU_DATA_LIBRARY=%SW_ICU_DIR%/usr/lib/icudt%SW_ICU_RELEASE%.lib
  set SW_ICU_UC_LIBRARY=%SW_ICU_DIR%/usr/lib/icuuc%SW_ICU_RELEASE%.lib
  set SW_ICU_I18N_LIBRARY=%SW_ICU_DIR%/usr/lib/icuin%SW_ICU_RELEASE%.lib
) else (
  set SW_ICU_DATA_LIBRARY=%SW_ICU_DIR%/usr/lib/sicudt%SW_ICU_RELEASE%.lib
  set SW_ICU_UC_LIBRARY=%SW_ICU_DIR%/usr/lib/sicuuc%SW_ICU_RELEASE%.lib
  set SW_ICU_I18N_LIBRARY=%SW_ICU_DIR%/usr/lib/sicuin%SW_ICU_RELEASE%.lib
)

cmake^
 -B %SW_FOUNDATION_BUILD_DIR%-test^
 -D BUILD_SHARED_LIBS=YES^
 -D CMAKE_BUILD_TYPE=Release^
 -D CMAKE_C_COMPILER=%SW_TOOLCHAIN_DIR%/usr/bin/clang-cl.exe^
 -D CMAKE_C_COMPILER_TARGET=%SW_PLATFORM%-unknown-windows-msvc^
 -D CMAKE_C_FLAGS="/GS- /Oy /Gw /Gy"^
 -D CMAKE_CXX_COMPILER=%SW_TOOLCHAIN_DIR%/usr/bin/clang-cl.exe^
 -D CMAKE_CXX_COMPILER_TARGET=%SW_PLATFORM%-unknown-windows-msvc^
 -D CMAKE_CXX_FLAGS="/GS- /Oy /Gw /Gy"^
 -D CMAKE_ASM_COMPILE_OPTIONS_MSVC_RUNTIME_LIBRARY_MultiThreadedDLL="/MD"^
 -D CMAKE_ASM_FLAGS="--target=%SW_PLATFORM%-unknown-windows-msvc"^
 -D CMAKE_MT=mt^
 -D CMAKE_INSTALL_PREFIX=%SW_SDK_INSTALL_DIR%^
 -D CMAKE_SYSTEM_NAME=Windows^
 -D CMAKE_SYSTEM_PROCESSOR=%SW_PLATFORM%^
 -D CMAKE_Swift_COMPILER=%SW_TOOLCHAIN_DIR%/usr/bin/swiftc.exe^
 -D CMAKE_Swift_COMPILER_TARGET=%SW_PLATFORM%-unknown-windows-msvc^
 -D CMAKE_Swift_FLAGS="-resource-dir %SW_SDK_INSTALL_DIR%/lib/swift -L%SW_SDK_INSTALL_DIR%/lib/swift/windows"^
 -G Ninja^
 -S %SW_FOUNDATION_SOURCES_DIR%^
 -D ENABLE_TESTING=YES^
 -D dispatch_DIR=%SW_DISPATCH_BUILD_DIR%/cmake/modules^
 -D XCTest_DIR=%SW_XCTEST_BUILD_DIR%/cmake/modules^
 -D ICU_ROOT=%SW_ICU_DIR%/usr^
 -D ICU_DATA_LIBRARY_RELEASE=%SW_ICU_DATA_LIBRARY%^
 -D ICU_UC_LIBRARY_RELEASE=%SW_ICU_UC_LIBRARY%^
 -D ICU_I18N_LIBRARY_RELEASE=%SW_ICU_I18N_LIBRARY%^
 -D LIBXML2_LIBRARY=%SW_XML2_DIR%/usr/lib/libxml2s.lib^
 -D LIBXML2_INCLUDE_DIR=%SW_XML2_DIR%/usr/include/libxml2^
 -D LIBXML2_DEFINITIONS="/DLIBXML_STATIC"^
 -D CURL_DIR=%SW_CURL_DIR%/usr/lib/cmake/CURL^
 -D ZLIB_ROOT=%SW_ZLIB_DIR%/usr^
 -D ZLIB_LIBRARY=%SW_ZLIB_DIR%/usr/lib/zlibstatic.lib

endlocal
