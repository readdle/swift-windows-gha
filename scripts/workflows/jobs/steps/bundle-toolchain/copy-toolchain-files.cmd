setlocal enabledelayedexpansion

set SW_DIR_XCTOOLCHAIN=%SW_BUNDLE_INSTALL_DIR%\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain
set SW_DIR_USR_BIN=%SW_DIR_XCTOOLCHAIN%\usr\bin
set SW_DIR_USR_INCLUDE=%SW_DIR_XCTOOLCHAIN%\usr\include
set SW_DIR_USR_INCLUDE_INTERNALSWIFTSCAN=%SW_DIR_USR_INCLUDE%\_InternalSwiftScan
set SW_DIR_USR_INCLUDE_CLANGC=%SW_DIR_USR_INCLUDE%\clang-c
set SW_DIR_USR_INCLUDE_DISPATCH=%SW_DIR_USR_INCLUDE%\dispatch
set SW_DIR_USR_INCLUDE_INDEXSTORE=%SW_DIR_USR_INCLUDE%\indexstore
set SW_DIR_USR_INCLUDE_LLDB=%SW_DIR_USR_INCLUDE%\lldb
set SW_DIR_USR_INCLUDE_LLVMC=%SW_DIR_USR_INCLUDE%\llvm-c
set SW_DIR_USR_INCLUDE_OS=%SW_DIR_USR_INCLUDE%\os
set SW_DIR_USR_INCLUDE_SOURCEKIT=%SW_DIR_USR_INCLUDE%\SourceKit
set SW_DIR_USR_LIB=%SW_DIR_XCTOOLCHAIN%\usr\lib
set SW_DIR_USR_LIB_CLANG=%SW_DIR_USR_LIB%\clang
set SW_DIR_USR_LIB_SITEPACKAGES=%SW_DIR_USR_LIB%\site-packages
set SW_DIR_USR_LIB_SITEPACKAGES_LLDB=%SW_DIR_USR_LIB_SITEPACKAGES%\lldb
set SW_DIR_USR_LIB_SITEPACKAGES_LLDB_FORMATTERS=%SW_DIR_USR_LIB_SITEPACKAGES_LLDB%\formatters
set SW_DIR_USR_LIB_SITEPACKAGES_LLDB_FORMATTERS_CPP=%SW_DIR_USR_LIB_SITEPACKAGES_LLDB_FORMATTERS%\cpp
set SW_DIR_USR_LIB_SITEPACKAGES_LLDB_UTILS=%SW_DIR_USR_LIB_SITEPACKAGES_LLDB%\utils
set SW_DIR_USR_LIB_SWIFT=%SW_DIR_USR_LIB%\swift
set SW_DIR_USR_LIB_SWIFT_MIGRATOR=%SW_DIR_USR_LIB_SWIFT%\migrator
set SW_DIR_USR_LIB_SWIFT_SHIMS=%SW_DIR_USR_LIB_SWIFT%\shims
set SW_DIR_USR_LIBEXEC=%SW_DIR_XCTOOLCHAIN%\usr\libexec
set SW_DIR_USR_SHARE=%SW_DIR_XCTOOLCHAIN%\usr\share
set SW_DIR_USR_SHARE_SWIFT=%SW_DIR_USR_SHARE%\swift

set SW_USR_BIN_FILENAMES=^
 llvm-dlltool.exe^
 llvm-lib.exe^
 llvm-ranlib.exe^
 llvm-readelf.exe^
 llvm-strip.exe^
 dsymutil.exe^
 llvm-ar.exe^
 llvm-cov.exe^
 llvm-cvtres.exe^
 llvm-cxxfilt.exe^
 llvm-dwarfdump.exe^
 llvm-dwp.exe^
 llvm-lipo.exe^
 llvm-mt.exe^
 llvm-nm.exe^
 llvm-objcopy.exe^
 llvm-objdump.exe^
 llvm-pdbutil.exe^
 llvm-profdata.exe^
 llvm-rc.exe^
 llvm-readobj.exe^
 llvm-size.exe^
 llvm-strings.exe^
 llvm-symbolizer.exe^
 llvm-undname.exe^
 LTO.dll^
 clang-cl.exe^
 clang-cpp.exe^
 clang++.exe^
 clang-format.exe^
 clang-tidy.exe^
 clang.exe^
 clangd.exe^
 libclang.dll^
 libIndexStore.dll^
 ld.lld.exe^
 ld64.lld.exe^
 lld-link.exe^
 wasm-ld.exe^
 lld.exe^
 lldb-server.exe^
 lldb-vscode.exe^
 lldb.exe^
 repl_swift.exe^
 liblldb.dll^
 BlocksRuntime.dll^
 dispatch.dll^
 sourcekitdInProc.dll^
 swift-api-digester.exe^
 swift-autolink-extract.exe^
 swift-symbolgraph-extract.exe^
 swift-demangle.exe^
 swift-frontend.exe^
 swiftDemangle.dll^
 _InternalSwiftScan.dll^
 swift.exe^
 swiftc.exe

set SW_USR_LIB_FILENAMES=^
 LTO.lib^
 libclang.lib^
 libIndexStore.lib^
 liblldb.lib^
 BlocksRuntime.lib^
 dispatch.lib^
 sourcekitdInProc.lib^
 swiftDemangle.lib

set SW_USR_INCLUDE_LLVMC_FILENAMES=^
 lto.h

set SW_USR_INCLUDE_CLANGC_FILENAMES=^
 BuildSystem.h^
 CXCompilationDatabase.h^
 CXErrorCode.h^
 CXString.h^
 Documentation.h^
 FatalErrorHandler.h^
 Index.h^
 Platform.h^
 Refactor.h

set SW_USR_INCLUDE_INDEXSTORE_FILENAMES=^
 indexstore.h^
 IndexStoreCXX.h

set SW_USR_INCLUDE_SOURCEKIT_FILENAMES=^
 sourcekitd.h

set SW_USR_INCLUDE_INTERNALSWIFTSCAN_FILENAMES=^
 DependencyScan.h^
 DependencyScanMacros.h^
 module.modulemap

set SW_USR_LIB_SITEPACKAGES_LLDB_FILENAMES=^
 __init__.py^
 _lldb.pyd^
 embedded_interpreter.py^
 lldb-argdumper.exe

set SW_USR_LIB_SITEPACKAGES_LLDB_FORMATTERS_FILENAMES=^
 Logger.py^
 __init__.py^
 attrib_fromdict.py^
 cache.py^
 metrics.py^
 synth.py

set SW_USR_LIB_SITEPACKAGES_LLDB_FORMATTERS_CPP_FILENAMES=^
 __init__.py^
 gnu_libstdcpp.py^
 libcxx.py

set SW_USR_LIB_SITEPACKAGES_LLDB_UTILS_FILENAMES=^
 __init__.py^
 in_call_stack.py^
 symbolication.py

set SW_USR_LIB_SWIFT_MIGRATOR_FILENAMES=^
 ios4.json^
 ios42.json^
 macos4.json^
 macos42.json^
 overlay4.json^
 overlay42.json^
 tvos4.json^
 tvos42.json^
 watchos4.json^
 watchos42.json

set SW_USR_SHARE_SWIFT_FILENAMES=^
 features.json

call :sw_copy_fileset %SW_TOOLCHAIN_DIR%\usr\bin %SW_DIR_USR_BIN% "%SW_USR_BIN_FILENAMES%" || (exit /b)
call :sw_copy_fileset %SW_TOOLCHAIN_DIR%\usr\lib %SW_DIR_USR_LIB% "%SW_USR_LIB_FILENAMES%" || (exit /b)
call :sw_copy_fileset %SW_TOOLCHAIN_DIR%\usr\lib\swift\windows %SW_DIR_USR_LIB% "_InternalSwiftScan.lib" || (exit /b)
call :sw_copy_fileset %SW_TOOLCHAIN_DIR%\usr\lib\swift\_InternalSwiftScan %SW_DIR_USR_INCLUDE_INTERNALSWIFTSCAN% "%SW_USR_INCLUDE_INTERNALSWIFTSCAN_FILENAMES%" || (exit /b)
call :sw_copy_fileset %SW_TOOLCHAIN_DIR%\usr\include\llvm-c %SW_DIR_USR_INCLUDE_LLVMC% "%SW_USR_INCLUDE_LLVMC_FILENAMES%" || (exit /b)
call :sw_copy_fileset %SW_TOOLCHAIN_DIR%\usr\include\clang-c %SW_DIR_USR_INCLUDE_CLANGC% "%SW_USR_INCLUDE_CLANGC_FILENAMES%" || (exit /b)
call :sw_copy_fileset %SW_TOOLCHAIN_DIR%\usr\include\SourceKit %SW_DIR_USR_INCLUDE_SOURCEKIT% "%SW_USR_INCLUDE_SOURCEKIT_FILENAMES%" || (exit /b)
call :sw_copy_fileset %SW_TOOLCHAIN_DIR%\usr\local\include\indexstore %SW_DIR_USR_INCLUDE_INDEXSTORE% "%SW_USR_INCLUDE_INDEXSTORE_FILENAMES%" || (exit /b)
call :sw_copy_fileset %SW_TOOLCHAIN_DIR%\usr\lib\site-packages\lldb %SW_DIR_USR_LIB_SITEPACKAGES_LLDB% "%SW_USR_LIB_SITEPACKAGES_LLDB_FILENAMES%" || (exit /b)
call :sw_copy_fileset %SW_TOOLCHAIN_DIR%\usr\lib\site-packages\lldb\formatters %SW_DIR_USR_LIB_SITEPACKAGES_LLDB_FORMATTERS% "%SW_USR_LIB_SITEPACKAGES_LLDB_FORMATTERS_FILENAMES%" || (exit /b)
call :sw_copy_fileset %SW_TOOLCHAIN_DIR%\usr\lib\site-packages\lldb\formatters\cpp %SW_DIR_USR_LIB_SITEPACKAGES_LLDB_FORMATTERS_CPP% "%SW_USR_LIB_SITEPACKAGES_LLDB_FORMATTERS_CPP_FILENAMES%" || (exit /b)
call :sw_copy_fileset %SW_TOOLCHAIN_DIR%\usr\lib\site-packages\lldb\utils %SW_DIR_USR_LIB_SITEPACKAGES_LLDB_UTILS% "%SW_USR_LIB_SITEPACKAGES_LLDB_UTILS_FILENAMES%" || (exit /b)
call :sw_copy_fileset %SW_TOOLCHAIN_DIR%\usr\lib\swift\migrator %SW_DIR_USR_LIB_SWIFT_MIGRATOR% "%SW_USR_LIB_SWIFT_MIGRATOR_FILENAMES%" || (exit /b)
call :sw_copy_fileset %SW_TOOLCHAIN_DIR%\usr\share\swift %SW_DIR_USR_SHARE_SWIFT% "%SW_USR_SHARE_SWIFT_FILENAMES%" || (exit /b)

call :sw_copy_dirset %SW_TOOLCHAIN_DIR%\usr\lib %SW_DIR_USR_LIB% "clang" || (exit /b)

endlocal
exit /b


rem ###########################################################################
:sw_copy_fileset <src_dir> <dst_dir> <filenames>
setlocal enabledelayedexpansion

for %%M in (%~3) do (
  if not exist %1\%%M (
    %SW_LOG_JOB_ERROR% --message "Source file not found: %1\%%M"
    exit /b 1
  )
  echo -- %2\%%M
  xcopy %1\%%M %2\ /y > nul || (exit /b)
)

endlocal
exit /b



rem ###########################################################################
:sw_copy_dirset <src_dir> <dst_dir> <dirs>
setlocal enabledelayedexpansion

for %%M in (%~3) do (
  if not exist %1\%%M (
    %SW_LOG_JOB_ERROR% --message "Source directory not found: %1\%%M"
    exit /b 1
  )
  echo -- %2\%%M
  xcopy %1\%%M %2\%%M\ /s /e /y > nul || (exit /b)
)

endlocal
exit /b
