set SW_DISPATCH_REPO=apple/swift-corelibs-libdispatch
set SW_DISPATCH_ORIGIN_URL=git://github.com/%SW_DISPATCH_REPO%.git

if [%SW_SWIFT_BRANCH_SPEC%]==[5.3] (
  set SW_LLVM_REF=swift/release/5.3
  set SW_CMARK_REF=release/5.3
  set SW_DISPATCH_REF=release/5.3
  set SW_SWIFT_REF=release/5.3
) else (
  set SW_LLVM_REF=swift/main
  set SW_CMARK_REF=main
  set SW_DISPATCH_REF=main
  set SW_SWIFT_REF=main
)

if [%SW_SWIFT_SDK_SPEC%]==[readdle] (
  set SW_DISPATCH_REPO=readdle/swift-corelibs-libdispatch
  set SW_DISPATCH_ORIGIN_URL=git://github.com/!SW_DISPATCH_REPO!.git
  set SW_DISPATCH_REF=swift-dev-windows-readdle
)

set "SW_LLVM_PROJECT_SOURCES_DIR=%SW_SOURCES_DIR%\llvm-project"
set "SW_LLVM_SOURCES_DIR=%SW_LLVM_PROJECT_SOURCES_DIR%\llvm"
set "SW_CMARK_SOURCES_DIR=%SW_SOURCES_DIR%\cmark"
set "SW_SWIFT_SOURCES_DIR=%SW_SOURCES_DIR%\swift"
set "SW_DISPATCH_SOURCES_DIR=%SW_SOURCES_DIR%\swift-corelibs-libdispatch"

set "SW_LLVM_TOOLS_BUILD_DIR=%SW_BUILD_DIR%\llvm-tools"
set "SW_TOOLCHAIN_BUILD_DIR=%SW_BUILD_DIR%\toolchain"

set "SW_TOOLCHAIN_INSTALL_DIR=%SW_INSTALL_DIR%\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr"
set "SW_ICU_PATH=%SW_ARTIFACTS_DIR%\Library\icu-%SW_ICU_VERSION%"

set "SW_LLVM_TABLEGEN=%SW_LLVM_TOOLS_BUILD_DIR%\bin\llvm-tblgen.exe"
set "SW_CLANG_TABLEGEN=%SW_LLVM_TOOLS_BUILD_DIR%\bin\clang-tblgen.exe"
set "SW_LLDB_TABLEGEN=%SW_LLVM_TOOLS_BUILD_DIR%\bin\lldb-tblgen.exe"
