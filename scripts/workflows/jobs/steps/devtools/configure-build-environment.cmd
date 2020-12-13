%SW_LOG_DEVTOOLS_INFO% --prefix="Starting step:" --message="Configure Build Environment"

set SW_LLBUILD_REF=main
set SW_TSC_REF=main
set SW_YAMS_REF=master
set SW_SAP_REF=main
set SW_SWIFT_DRIVER_REF=main
set SW_SPM_REF=main
set SW_INDEXSTORE_DB_REF=main
set SW_SOURCEKIT_REF=main

set "SW_LLBUILD_SOURCES_DIR=%SW_SOURCES_DIR%\swift-llbuild"
set "SW_LLBUILD_BUILD_DIR=%SW_BUILD_DIR%\swift-llbuild"
set "SW_TSC_SOURCES_DIR=%SW_SOURCES_DIR%\swift-tools-support-core"
set "SW_TSC_BUILD_DIR=%SW_BUILD_DIR%\swift-tools-support-core"
set "SW_YAMS_SOURCES_DIR=%SW_SOURCES_DIR%\Yams"
set "SW_YAMS_BUILD_DIR=%SW_BUILD_DIR%\Yams"
set "SW_SAP_SOURCES_DIR=%SW_SOURCES_DIR%\swift-argument-parser"
set "SW_SAP_BUILD_DIR=%SW_BUILD_DIR%\swift-argument-parser"
set "SW_SWIFT_DRIVER_SOURCES_DIR=%SW_SOURCES_DIR%\swift-driver"
set "SW_SWIFT_DRIVER_BUILD_DIR=%SW_BUILD_DIR%\swift-driver"
set "SW_SPM_SOURCES_DIR=%SW_SOURCES_DIR%\swift-package-manager"
set "SW_SPM_BUILD_DIR=%SW_BUILD_DIR%\swift-package-manager"
set "SW_INDEXSTORE_DB_SOURCES_DIR=%SW_SOURCES_DIR%\indexstore-db"
set "SW_INDEXSTORE_DB_BUILD_DIR=%SW_BUILD_DIR%\indexstore-db"
set "SW_SOURCEKIT_SOURCES_DIR=%SW_SOURCES_DIR%\sourcekit-lsp"
set "SW_SOURCEKIT_BUILD_DIR=%SW_BUILD_DIR%\sourcekit-lsp"

set "SW_TOOLCHAIN_DIR=%SW_ARTIFACTS_DIR%\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain"
set "SW_SDK_DIR=%SW_ARTIFACTS_DIR%\Library\Developer\Platforms\Windows.platform\Developer\SDKs\Windows.sdk"
set "SW_DEVELOPER_LIBRARY_DIR=%SW_ARTIFACTS_DIR%\Library\Developer\Platforms\Windows.platform\Developer\Library"

set "SW_TOOLCHAIN_INSTALL_DIR=%SW_INSTALL_DIR%\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr"

set "SW_SQLITE_DIR=%SW_ARTIFACTS_DIR%\Library\sqlite-%SW_SQLITE_VERSION%"

set "SW_ICU_DIR=%SW_ARTIFACTS_DIR%\Library\icu-%SW_ICU_VERSION%"

set "PATH=%SW_TOOLCHAIN_DIR%\usr\bin;%SW_SDK_DIR%\usr\bin;%SW_ICU_DIR%\usr\bin;%SW_LLBUILD_BUILD_DIR%\bin;%SW_TSC_BUILD_DIR%\bin;%SW_YAMS_BUILD_DIR%\bin;%SW_SWIFT_DRIVER_BUILD_DIR%\bin;%SW_SAP_BUILD_DIR%\bin;%SW_SPM_BUILD_DIR%\bin;%PATH%"
set "SWIFTPM_PD_LIBS=%SW_SPM_BUILD_DIR%\pm"
