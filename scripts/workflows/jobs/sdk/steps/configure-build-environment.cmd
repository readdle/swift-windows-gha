call .github\workflows\vsenv.cmd -arch=x64 -host_arch=x64

set SW_ARTIFACTS_PATH=%GITHUB_WORKSPACE%\a
set SW_SOURCES_PATH=%GITHUB_WORKSPACE%\s
set SW_BINARIES_PATH=%GITHUB_WORKSPACE%\b

set SW_PLATFORM_PATH=%GITHUB_WORKSPACE%\i\Library\Developer\Platforms\Windows.platform

set SW_SDK_PATH=%SW_PLATFORM_PATH%\Developer\SDKs\Windows.sdk
set SW_INSTALL_PATH=%SW_SDK_PATH%\usr
set SW_XCTEST_INSTALL_PATH=%SW_PLATFORM_PATH%\Developer\Library\XCTest-development\usr

set SW_TOOLCHAIN_PATH=%SW_ARTIFACTS_PATH%\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain
set SW_CURL_PATH=%SW_ARTIFACTS_PATH%\Library\libcurl-%SW_CURL_VERSION%
set SW_ICU_PATH=%SW_ARTIFACTS_PATH%\Library\icu-%SW_ICU_VERSION%
set SW_XML2_PATH=%SW_ARTIFACTS_PATH%\Library\libxml2-%SW_XML2_VERSION%
set SW_ZLIB_PATH=%SW_ARTIFACTS_PATH%\Library\zlib-%SW_ZLIB_VERSION%

set CTEST_OUTPUT_ON_FAILURE=1

set PATH=%SW_TOOLCHAIN_PATH%\usr\bin;%PATH%


echo ::set-env name=SW_ARTIFACTS_PATH::%SW_ARTIFACTS_PATH%
echo ::set-env name=SW_SOURCES_PATH::%SW_SOURCES_PATH%
echo ::set-env name=SW_BINARIES_PATH::%SW_BINARIES_PATH%

echo ::set-env name=SW_PLATFORM_PATH::%SW_PLATFORM_PATH%

echo ::set-env name=SW_SDK_PATH::%SW_SDK_PATH%
echo ::set-env name=SW_INSTALL_PATH::%SW_INSTALL_PATH%
echo ::set-env name=SW_XCTEST_INSTALL_PATH::%SW_XCTEST_INSTALL_PATH%

echo ::set-env name=SW_TOOLCHAIN_PATH::%SW_TOOLCHAIN_PATH%
echo ::set-env name=SW_CURL_PATH::%SW_CURL_PATH%
echo ::set-env name=SW_ICU_PATH::%SW_ICU_PATH%
echo ::set-env name=SW_XML2_PATH::%SW_XML2_PATH%
echo ::set-env name=SW_ZLIB_PATH::%SW_ZLIB_PATH%

echo ::set-env name=PATH::%PATH%

echo ::set-env name=CTEST_OUTPUT_ON_FAILURE::%CTEST_OUTPUT_ON_FAILURE%

copy %SW_SOURCES_PATH%\swift\stdlib\public\Platform\ucrt.modulemap "%UniversalCRTSdkDir%\Include\%UCRTVersion%\ucrt\module.modulemap"
copy %SW_SOURCES_PATH%\swift\stdlib\public\Platform\visualc.modulemap "%VCToolsInstallDir%\include\module.modulemap"
copy %SW_SOURCES_PATH%\swift\stdlib\public\Platform\visualc.apinotes "%VCToolsInstallDir%\include\visualc.apinotes"
copy %SW_SOURCES_PATH%\swift\stdlib\public\Platform\winsdk.modulemap "%UniversalCRTSdkDir%\Include\%UCRTVersion%\um\module.modulemap"
