%SW_LOG_DEVTOOLS_INFO% --prefix="Starting step:" --message="Configure Build Environment"

%SW_SET_ENV% SW_LLBUILD_REF main
%SW_SET_ENV% SW_YAMS_REF master

%SW_SET_ENV% SW_LLBUILD_SOURCES_DIR %SW_SOURCES_DIR%\swift-llbuild
%SW_SET_ENV% SW_LLBUILD_BUILD_DIR %SW_BUILD_DIR%\swift-llbuild
%SW_SET_ENV% SW_YAMS_SOURCES_DIR %SW_SOURCES_DIR%\Yams
%SW_SET_ENV% SW_YAMS_BUILD_DIR %SW_BUILD_DIR%\Yams

%SW_SET_ENV% SW_TOOLCHAIN_DIR %SW_ARTIFACTS_DIR%\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain
%SW_SET_ENV% SW_SDK_DIR %SW_ARTIFACTS_DIR%\Library\Developer\Platforms\Windows.platform\Developer\SDKs\Windows.sdk
%SW_SET_ENV% SW_DEVELOPER_LIBRARY_DIR %SW_ARTIFACTS_DIR%\Library\Developer\Platforms\Windows.platform\Developer\Library
%SW_SET_ENV% SW_TOOLCHAIN_INSTALL_DIR %SW_INSTALL_DIR%\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr

%SW_SET_ENV% SW_SQLITE_DIR %SW_ARTIFACTS_DIR%\Library\sqlite-%SW_SQLITE_VERSION%

%SW_SET_ENV% PATH "%SW_TOOLCHAIN_DIR%\usr\bin;%PATH%"
