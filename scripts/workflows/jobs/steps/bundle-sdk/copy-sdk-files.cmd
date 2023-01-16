setlocal enabledelayedexpansion

set SW_DIR_PLATFORM=%SW_BUNDLE_INSTALL_DIR%\Library\Developer\Platforms\Windows.platform
set SW_DIR_XCTEST=%SW_DIR_PLATFORM%\Developer\Library\XCTest-development
set SW_DIR_XCTEST_USR=%SW_DIR_XCTEST%\usr
set SW_DIR_XCTEST_USR_BIN64=%SW_DIR_XCTEST_USR%\bin64
set SW_DIR_XCTEST_USR_LIB=%SW_DIR_XCTEST_USR%\lib
set SW_DIR_XCTEST_USR_LIB_SWIFT=%SW_DIR_XCTEST_USR_LIB%\swift
set SW_DIR_XCTEST_USR_LIB_SWIFT_WINDOWS=%SW_DIR_XCTEST_USR_LIB_SWIFT%\windows
set SW_DIR_XCTEST_USR_LIB_SWIFT_WINDOWS_X86_64=%SW_DIR_XCTEST_USR_LIB_SWIFT_WINDOWS%\x86_64
set SW_DIR_XCTEST_SWIFTMODULE=%SW_DIR_XCTEST_USR_LIB_SWIFT_WINDOWS_X86_64%\XCTest.swiftmodule

set SW_DIR_SDKS=%SW_DIR_PLATFORM%\Developer\SDKs
set SW_DIR_WINDOWSSDK=%SW_DIR_SDKS%\Windows.sdk

set SW_DIR_WINDOWSSDK_USR=%SW_DIR_WINDOWSSDK%\usr
set SW_DIR_WINDOWSSDK_USR_INCLUDE=%SW_DIR_WINDOWSSDK_USR%\include
set SW_DIR_WINDOWSSDK_USR_INCLUDE_BLOCK=%SW_DIR_WINDOWSSDK_USR_INCLUDE%\Block
set SW_DIR_WINDOWSSDK_USR_INCLUDE_DISPATCH=%SW_DIR_WINDOWSSDK_USR_INCLUDE%\dispatch
set SW_DIR_WINDOWSSDK_USR_INCLUDE_OS=%SW_DIR_WINDOWSSDK_USR_INCLUDE%\os
set SW_DIR_WINDOWSSDK_USR_INCLUDE_SWIFT=%SW_DIR_WINDOWSSDK_USR_INCLUDE%\swift
set SW_DIR_WINDOWSSDK_USR_INCLUDE_SWIFT_SWIFTREMOTEMIRROR=%SW_DIR_WINDOWSSDK_USR_INCLUDE_SWIFT%\SwiftRemoteMirror

set SW_DIR_WINDOWSSDK_USR_LIB=%SW_DIR_WINDOWSSDK_USR%\lib
set SW_DIR_WINDOWSSDK_USR_LIB_SWIFT=%SW_DIR_WINDOWSSDK_USR_LIB%\swift
set SW_DIR_WINDOWSSDK_USR_LIB_SWIFT_SHIMS=%SW_DIR_WINDOWSSDK_USR_LIB_SWIFT%\shims
set SW_DIR_WINDOWSSDK_USR_LIB_SWIFT_WINDOWS=%SW_DIR_WINDOWSSDK_USR_LIB_SWIFT%\windows
set SW_DIR_CONCURRENCY_SWIFTMODULE=%SW_DIR_WINDOWSSDK_USR_LIB_SWIFT_WINDOWS%\_Concurrency.swiftmodule
set SW_DIR_DIFFERENTIATION_SWIFTMODULE=%SW_DIR_WINDOWSSDK_USR_LIB_SWIFT_WINDOWS%\_Differentiation.swiftmodule
set SW_DIR_DISTRIBUTED_SWIFTMODULE=%SW_DIR_WINDOWSSDK_USR_LIB_SWIFT_WINDOWS%\Distributed.swiftmodule
set SW_DIR_REGEXPARSER_SWIFTMODULE=%SW_DIR_WINDOWSSDK_USR_LIB_SWIFT_WINDOWS%\_RegexParser.swiftmodule
set SW_DIR_STRINGPROCESSING_SWIFTMODULE=%SW_DIR_WINDOWSSDK_USR_LIB_SWIFT_WINDOWS%\_StringProcessing.swiftmodule
set SW_DIR_CRT_SWIFTMODULE=%SW_DIR_WINDOWSSDK_USR_LIB_SWIFT_WINDOWS%\CRT.swiftmodule
set SW_DIR_CXX_SWIFTMODULE=%SW_DIR_WINDOWSSDK_USR_LIB_SWIFT_WINDOWS%\Cxx.swiftmodule
set SW_DIR_DISPATCH_SWIFTMODULE=%SW_DIR_WINDOWSSDK_USR_LIB_SWIFT_WINDOWS%\Dispatch.swiftmodule
set SW_DIR_FOUNDATION_SWIFTMODULE=%SW_DIR_WINDOWSSDK_USR_LIB_SWIFT_WINDOWS%\Foundation.swiftmodule
set SW_DIR_FOUNDATIONNETWORKING_SWIFTMODULE=%SW_DIR_WINDOWSSDK_USR_LIB_SWIFT_WINDOWS%\FoundationNetworking.swiftmodule
set SW_DIR_FOUNDATIONXML_SWIFTMODULE=%SW_DIR_WINDOWSSDK_USR_LIB_SWIFT_WINDOWS%\FoundationXML.swiftmodule
set SW_DIR_SWIFT_SWIFTMODULE=%SW_DIR_WINDOWSSDK_USR_LIB_SWIFT_WINDOWS%\Swift.swiftmodule
set SW_DIR_SWIFTONONESUPPORT_SWIFTMODULE=%SW_DIR_WINDOWSSDK_USR_LIB_SWIFT_WINDOWS%\SwiftOnoneSupport.swiftmodule
set SW_DIR_WINSDK_SWIFTMODULE=%SW_DIR_WINDOWSSDK_USR_LIB_SWIFT_WINDOWS%\WinSDK.swiftmodule
set SW_DIR_WINDOWSSDK_USR_LIB_SWIFT_WINDOWS_X86_64=%SW_DIR_WINDOWSSDK_USR_LIB_SWIFT_WINDOWS%\x86_64

set SW_DIR_WINDOWSSDK_USR_SHARE=%SW_DIR_WINDOWSSDK_USR%\share

set SW_WINDOWSSDK_USR_INCLUDE_SWIFT_SWIFTREMOTEMIRROR_FILENAMES=^
  MemoryReaderInterface.h^
  Platform.h^
  SwiftRemoteMirror.h^
  SwiftRemoteMirrorTypes.h^
  module.modulemap

set SW_WINDOWSSDK_USR_INCLUDE_DISPATCH_FILENAMES=^
  base.h^
  block.h^
  data.h^
  dispatch.h^
  group.h^
  introspection.h^
  io.h^
  module.modulemap^
  object.h^
  once.h^
  queue.h^
  semaphore.h^
  source.h^
  time.h

set SW_WINDOWSSDK_USR_INCLUDE_OS_FILENAMES=^
  generic_unix_base.h^
  generic_win_base.h^
  object.h

set SW_WINDOWSSDK_USR_LIB_SWIFT_WINDOWS_X86_64_FILENAMES_1=^
  swiftRemoteMirror.lib^
  swift_Concurrency.lib^
  swift_Differentiation.lib^
  swiftDistributed.lib^
  swift_RegexParser.lib^
  swift_StringProcessing.lib^
  swiftCRT.lib^
  swiftCxx.lib^
  swiftCore.lib^
  swiftSwiftOnoneSupport.lib^
  swiftWinSDK.lib^
  swiftrt.obj^
  libcxxshim.h^
  libcxxshim.modulemap

set SW_WINDOWSSDK_USR_LIB_SWIFT_WINDOWS_X86_64_FILENAMES_2=^
  BlocksRuntime.lib^
  dispatch.lib^
  swiftDispatch.lib^
  Foundation.lib^
  FoundationNetworking.lib^
  FoundationXML.lib

set SW_GENERIC_SWIFTMODULE_FILENAMES=^
  x86_64-unknown-windows-msvc.swiftdoc^
  x86_64-unknown-windows-msvc.swiftinterface^
  x86_64-unknown-windows-msvc.swiftmodule

set SW_PLATFORM_FILES=^
  ucrt.modulemap^
  winsdk.modulemap^
  vcruntime.modulemap^
  vcruntime.apinotes

call :sw_copy_fileset %SW_PLATFORM_DIR%\Developer\Library\XCTest-development\usr\bin %SW_DIR_XCTEST_USR_BIN64% "XCTest.dll" || (exit /b)
call :sw_copy_fileset %SW_PLATFORM_DIR%\Developer\Library\XCTest-development\usr\lib\swift\windows %SW_DIR_XCTEST_USR_LIB_SWIFT_WINDOWS_X86_64% "XCTest.lib" || (exit /b)
call :sw_copy_file %SW_PLATFORM_DIR%\Developer\Library\XCTest-development\usr\lib\swift\windows\x86_64\XCTest.swiftdoc %SW_DIR_XCTEST_SWIFTMODULE%\x86_64-unknown-windows-msvc.swiftdoc || (exit /b)
call :sw_copy_file %SW_PLATFORM_DIR%\Developer\Library\XCTest-development\usr\lib\swift\windows\x86_64\XCTest.swiftmodule %SW_DIR_XCTEST_SWIFTMODULE%\x86_64-unknown-windows-msvc.swiftmodule || (exit /b)
call :sw_copy_fileset %SW_SDK_DIR%\usr\include\swift\SwiftRemoteMirror %SW_DIR_WINDOWSSDK_USR_INCLUDE_SWIFT_SWIFTREMOTEMIRROR% "%SW_WINDOWSSDK_USR_INCLUDE_SWIFT_SWIFTREMOTEMIRROR_FILENAMES%" || (exit /b)
call :sw_copy_fileset %SW_SDK_DIR%\usr\lib\swift\windows\x86_64 %SW_DIR_WINDOWSSDK_USR_LIB_SWIFT_WINDOWS_X86_64% "%SW_WINDOWSSDK_USR_LIB_SWIFT_WINDOWS_X86_64_FILENAMES_1%" || (exit /b)
call :sw_copy_fileset %SW_SDK_DIR%\usr\lib\swift\Block %SW_DIR_WINDOWSSDK_USR_INCLUDE_BLOCK% "Block.h" || (exit /b)
call :sw_copy_fileset %SW_SDK_DIR%\usr\lib\swift\windows %SW_DIR_WINDOWSSDK_USR_LIB_SWIFT_WINDOWS_X86_64% "%SW_WINDOWSSDK_USR_LIB_SWIFT_WINDOWS_X86_64_FILENAMES_2%" || (exit /b)
call :sw_copy_fileset %SW_SDK_DIR%\usr\lib\swift\dispatch %SW_DIR_WINDOWSSDK_USR_INCLUDE_DISPATCH% "%SW_WINDOWSSDK_USR_INCLUDE_DISPATCH_FILENAMES%" || (exit /b)
call :sw_copy_fileset %SW_SDK_DIR%\usr\lib\swift\os %SW_DIR_WINDOWSSDK_USR_INCLUDE_OS% "%SW_WINDOWSSDK_USR_INCLUDE_OS_FILENAMES%" || (exit /b)
call :sw_copy_file %SW_SDK_DIR%\usr\lib\swift\windows\x86_64\Dispatch.swiftdoc %SW_DIR_DISPATCH_SWIFTMODULE%\x86_64-unknown-windows-msvc.swiftdoc || (exit /b)
call :sw_copy_file %SW_SDK_DIR%\usr\lib\swift\windows\x86_64\Dispatch.swiftmodule %SW_DIR_DISPATCH_SWIFTMODULE%\x86_64-unknown-windows-msvc.swiftmodule || (exit /b)
call :sw_copy_file %SW_SDK_DIR%\usr\lib\swift\windows\x86_64\Foundation.swiftdoc %SW_DIR_FOUNDATION_SWIFTMODULE%\x86_64-unknown-windows-msvc.swiftdoc || (exit /b)
call :sw_copy_file %SW_SDK_DIR%\usr\lib\swift\windows\x86_64\Foundation.swiftmodule %SW_DIR_FOUNDATION_SWIFTMODULE%\x86_64-unknown-windows-msvc.swiftmodule || (exit /b)
call :sw_copy_file %SW_SDK_DIR%\usr\lib\swift\windows\x86_64\FoundationNetworking.swiftdoc %SW_DIR_FOUNDATIONNETWORKING_SWIFTMODULE%\x86_64-unknown-windows-msvc.swiftdoc || (exit /b)
call :sw_copy_file %SW_SDK_DIR%\usr\lib\swift\windows\x86_64\FoundationNetworking.swiftmodule %SW_DIR_FOUNDATIONNETWORKING_SWIFTMODULE%\x86_64-unknown-windows-msvc.swiftmodule || (exit /b)
call :sw_copy_file %SW_SDK_DIR%\usr\lib\swift\windows\x86_64\FoundationXML.swiftdoc %SW_DIR_FOUNDATIONXML_SWIFTMODULE%\x86_64-unknown-windows-msvc.swiftdoc || (exit /b)
call :sw_copy_file %SW_SDK_DIR%\usr\lib\swift\windows\x86_64\FoundationXML.swiftmodule %SW_DIR_FOUNDATIONXML_SWIFTMODULE%\x86_64-unknown-windows-msvc.swiftmodule || (exit /b)
call :sw_copy_fileset %SW_SDK_DIR%\usr\lib\swift\windows\_Concurrency.swiftmodule %SW_DIR_CONCURRENCY_SWIFTMODULE% "%SW_GENERIC_SWIFTMODULE_FILENAMES%" || (exit /b)
call :sw_copy_fileset %SW_SDK_DIR%\usr\lib\swift\windows\_Differentiation.swiftmodule %SW_DIR_DIFFERENTIATION_SWIFTMODULE% "%SW_GENERIC_SWIFTMODULE_FILENAMES%" || (exit /b)
call :sw_copy_fileset %SW_SDK_DIR%\usr\lib\swift\windows\Distributed.swiftmodule %SW_DIR_DISTRIBUTED_SWIFTMODULE% "%SW_GENERIC_SWIFTMODULE_FILENAMES%" || (exit /b)
call :sw_copy_fileset %SW_SDK_DIR%\usr\lib\swift\windows\_RegexParser.swiftmodule %SW_DIR_REGEXPARSER_SWIFTMODULE% "%SW_GENERIC_SWIFTMODULE_FILENAMES%" || (exit /b)
call :sw_copy_fileset %SW_SDK_DIR%\usr\lib\swift\windows\_StringProcessing.swiftmodule %SW_DIR_STRINGPROCESSING_SWIFTMODULE% "%SW_GENERIC_SWIFTMODULE_FILENAMES%" || (exit /b)
call :sw_copy_fileset %SW_SDK_DIR%\usr\lib\swift\windows\CRT.swiftmodule %SW_DIR_CRT_SWIFTMODULE% "%SW_GENERIC_SWIFTMODULE_FILENAMES%" || (exit /b)
call :sw_copy_fileset %SW_SDK_DIR%\usr\lib\swift\windows\Cxx.swiftmodule %SW_DIR_CXX_SWIFTMODULE% "%SW_GENERIC_SWIFTMODULE_FILENAMES%" || (exit /b)
call :sw_copy_fileset %SW_SDK_DIR%\usr\lib\swift\windows\Swift.swiftmodule %SW_DIR_SWIFT_SWIFTMODULE% "%SW_GENERIC_SWIFTMODULE_FILENAMES%" || (exit /b)
call :sw_copy_fileset %SW_SDK_DIR%\usr\lib\swift\windows\SwiftOnoneSupport.swiftmodule %SW_DIR_SWIFTONONESUPPORT_SWIFTMODULE% "%SW_GENERIC_SWIFTMODULE_FILENAMES%" || (exit /b)
call :sw_copy_fileset %SW_SDK_DIR%\usr\lib\swift\windows\WinSDK.swiftmodule %SW_DIR_WINSDK_SWIFTMODULE% "%SW_GENERIC_SWIFTMODULE_FILENAMES%" || (exit /b)
call :sw_copy_fileset %SW_SWIFT_SOURCES_DIR%\stdlib\public\Platform %SW_DIR_WINDOWSSDK_USR_SHARE% "%SW_PLATFORM_FILES%" || (exit /b)
call :sw_copy_fileset %SW_PLATFORM_DIR% %SW_DIR_PLATFORM% "Info.plist" || (exit /b)
call :sw_copy_fileset %SW_SDK_DIR% %SW_DIR_WINDOWSSDK% "SDKSettings.plist" || (exit /b)
call :sw_copy_dirset %SW_SDK_DIR%\usr\lib\swift %SW_DIR_WINDOWSSDK_USR_LIB_SWIFT% "shims" || (exit /b)

endlocal
exit /b



rem ###########################################################################
:sw_copy_file <src_file> <dst_file>
setlocal enabledelayedexpansion

if not exist %1 (
  %SW_LOG_JOB_ERROR% --message "Source file not found: %1"
  exit /b 1
)

echo -- %2
echo F|xcopy %1 %2 /y > nul

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
