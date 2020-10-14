%SW_LOG_DEVTOOLS_INFO% --prefix="Starting step:" --message="Configure Build Environment"

%SW_SET_ENV% SW_LLBUILD_REF main
%SW_SET_ENV% SW_TSC_REF main
%SW_SET_ENV% SW_YAMS_REF master
%SW_SET_ENV% SW_SAP_REF main
%SW_SET_ENV% SW_SWIFT_DRIVER_REF main
%SW_SET_ENV% SW_SPM_REF main
%SW_SET_ENV% SW_INDEXSTORE_DB_REF main
%SW_SET_ENV% SW_SOURCEKIT_REF main

%SW_SET_ENV% SW_LLBUILD_SOURCES_DIR %SW_SOURCES_DIR%\swift-llbuild
%SW_SET_ENV% SW_LLBUILD_BUILD_DIR %SW_BUILD_DIR%\swift-llbuild
%SW_SET_ENV% SW_TSC_SOURCES_DIR %SW_SOURCES_DIR%\swift-tools-support-core
%SW_SET_ENV% SW_TSC_BUILD_DIR %SW_BUILD_DIR%\swift-tools-support-core
%SW_SET_ENV% SW_YAMS_SOURCES_DIR %SW_SOURCES_DIR%\Yams
%SW_SET_ENV% SW_YAMS_BUILD_DIR %SW_BUILD_DIR%\Yams
%SW_SET_ENV% SW_SAP_SOURCES_DIR %SW_SOURCES_DIR%\swift-argument-parser
%SW_SET_ENV% SW_SAP_BUILD_DIR %SW_BUILD_DIR%\swift-argument-parser
%SW_SET_ENV% SW_SWIFT_DRIVER_SOURCES_DIR %SW_SOURCES_DIR%\swift-driver
%SW_SET_ENV% SW_SWIFT_DRIVER_BUILD_DIR %SW_BUILD_DIR%\swift-driver
%SW_SET_ENV% SW_SPM_SOURCES_DIR %SW_SOURCES_DIR%\swift-package-manager
%SW_SET_ENV% SW_SPM_BUILD_DIR %SW_BUILD_DIR%\swift-package-manager
%SW_SET_ENV% SW_INDEXSTORE_DB_SOURCES_DIR %SW_SOURCES_DIR%\indexstore-db
%SW_SET_ENV% SW_INDEXSTORE_DB_BUILD_DIR %SW_BUILD_DIR%\indexstore-db
%SW_SET_ENV% SW_SOURCEKIT_SOURCES_DIR %SW_SOURCES_DIR%\sourcekit-lsp
%SW_SET_ENV% SW_SOURCEKIT_BUILD_DIR %SW_BUILD_DIR%\sourcekit-lsp

%SW_SET_ENV% SW_TOOLCHAIN_DIR %SW_ARTIFACTS_DIR%\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain
%SW_SET_ENV% SW_SDK_DIR %SW_ARTIFACTS_DIR%\Library\Developer\Platforms\Windows.platform\Developer\SDKs\Windows.sdk
%SW_SET_ENV% SW_DEVELOPER_LIBRARY_DIR %SW_ARTIFACTS_DIR%\Library\Developer\Platforms\Windows.platform\Developer\Library

%SW_SET_ENV% SW_TOOLCHAIN_INSTALL_DIR %SW_INSTALL_DIR%\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr

%SW_SET_ENV% SW_SQLITE_DIR %SW_ARTIFACTS_DIR%\Library\sqlite-%SW_SQLITE_VERSION%

set SW_ICU_DIR=%SW_ARTIFACTS_DIR%\Library\icu-%SW_ICU_VERSION%

%SW_SET_ENV% PATH "%SW_TOOLCHAIN_DIR%\usr\bin;%SW_SDK_DIR%\usr\bin;%SW_ICU_DIR%\usr\bin;%SW_LLBUILD_BUILD_DIR%\bin;%SW_TSC_BUILD_DIR%\bin;%SW_YAMS_BUILD_DIR%\bin;%SW_SWIFT_DRIVER_BUILD_DIR%\bin;%SW_SAP_BUILD_DIR%\bin;%SW_SPM_BUILD_DIR%\bin;%PATH%"
%SW_SET_ENV% SWIFTPM_PD_LIBS "%SW_SPM_BUILD_DIR%\pm"
set
