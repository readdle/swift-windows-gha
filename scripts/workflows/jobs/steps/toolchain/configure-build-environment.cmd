
set "SW_LOG_JOB_INFO=%SW_LOG_INFO% --scope toolchain"
set "SW_LOG_JOB_WARNING=%SW_LOG_WARNING% --scope toolchain"

%SW_LOG_JOB_INFO% --message="Configuring build environment"

if not defined SW_PYTHON_DIR (
  call :sw_find_python SW_PYTHON_DIR
)

call :sw_get_ref SW_SWIFT_EXPERIMENTAL_STRING_PROCESSING_REF swift/
call :sw_get_ref SW_SWIFT_SYNTAX_REF

set "SW_LLVM_PROJECT_SOURCES_DIR=%SW_SOURCES_DIR%\llvm-project"
set "SW_CMARK_SOURCES_DIR=%SW_SOURCES_DIR%\cmark"
set "SW_SWIFT_SOURCES_DIR=%SW_SOURCES_DIR%\swift"
set "SW_DISPATCH_SOURCES_DIR=%SW_SOURCES_DIR%\swift-corelibs-libdispatch"
set "SW_SWIFT_SYNTAX_SOURCES_DIR=%SW_SOURCES_DIR%\swift-syntax"
set "SW_SWIFT_EXPERIMENTAL_STRING_PROCESSING_SOURCES_DIR=%SW_SOURCES_DIR%\swift-experimental-string-processing"

set "SW_LLVM_TOOLS_DIR=%SW_ARTIFACTS_DIR%\build-tools\bin"
set "SW_LLVM_TABLEGEN=%SW_LLVM_TOOLS_DIR%\llvm-tblgen.exe"
set "SW_CLANG_TABLEGEN=%SW_LLVM_TOOLS_DIR%\clang-tblgen.exe"
set "SW_LLDB_TABLEGEN=%SW_LLVM_TOOLS_DIR%\lldb-tblgen.exe"
set "SW_LLVM_CONFIG=%SW_LLVM_TOOLS_DIR%\llvm-config.exe"

set "SW_TOOLCHAIN_BUILD_DIR=%SW_BUILD_DIR%\toolchain"

set "SW_TOOLCHAIN_INSTALL_DIR=%SW_INSTALL_DIR%\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr"

%SW_LOG_JOB_INFO% --prefix="%SW_DISPATCH_REPO%:                         " --message="%SW_DISPATCH_REF%"
%SW_LOG_JOB_INFO% --prefix="apple/swift-cmark:                          " --message="%SW_CMARK_REF%"
%SW_LOG_JOB_INFO% --prefix="apple/swift-syntax:                         " --message="%SW_SWIFT_SYNTAX_REF%"
%SW_LOG_JOB_INFO% --prefix="apple/llvm-project:                         " --message="%SW_LLVM_REF%"
%SW_LOG_JOB_INFO% --prefix="apple/swift:                                " --message="%SW_SWIFT_REF%"
%SW_LOG_JOB_INFO% --prefix="apple/swift-experimental-string-processing: " --message="%SW_SWIFT_EXPERIMENTAL_STRING_PROCESSING_REF%"
%SW_LOG_JOB_INFO%
%SW_LOG_JOB_INFO% --prefix="%SW_DISPATCH_REPO% sources: " --message="%SW_DISPATCH_SOURCES_DIR%"
%SW_LOG_JOB_INFO% --prefix="apple/swift-cmark sources:  " --message="%SW_CMARK_SOURCES_DIR%"
%SW_LOG_JOB_INFO% --prefix="apple/swift-syntax sources: " --message="%SW_SWIFT_SYNTAX_SOURCES_DIR%"
%SW_LOG_JOB_INFO% --prefix="apple/llvm-project sources: " --message="%SW_LLVM_PROJECT_SOURCES_DIR%"
%SW_LOG_JOB_INFO% --prefix="apple/swift sources:        " --message="%SW_SWIFT_SOURCES_DIR%"
%SW_LOG_JOB_INFO% --prefix="apple/swift-experimental-string-processing sources: " --message="%SW_SWIFT_EXPERIMENTAL_STRING_PROCESSING_SOURCES_DIR%"
%SW_LOG_JOB_INFO%
%SW_LOG_JOB_INFO% --prefix="Toolchain build dir:     " --message="%SW_TOOLCHAIN_BUILD_DIR%"
%SW_LOG_JOB_INFO%
%SW_LOG_JOB_INFO% --prefix="Toolchain install dir:   " --message="%SW_TOOLCHAIN_INSTALL_DIR%"
%SW_LOG_JOB_INFO%
%SW_LOG_JOB_INFO% --prefix="llvm-tblgen:             " --message="%SW_LLVM_TABLEGEN%"
%SW_LOG_JOB_INFO% --prefix="clang-tblgen:            " --message="%SW_CLANG_TABLEGEN%"
%SW_LOG_JOB_INFO% --prefix="lldb-tblgen:             " --message="%SW_LLDB_TABLEGEN%"
%SW_LOG_JOB_INFO% --prefix="llvm-config:             " --message="%SW_LLVM_CONFIG%"
%SW_LOG_JOB_INFO% --prefix="Python location:         " --message="%SW_PYTHON_DIR%"
%SW_LOG_JOB_INFO%

exit /b 0


rem ###########################################################################
:sw_get_ref <result_var> <prefix>
setlocal enabledelayedexpansion

set PREFIX=%2

if %SW_SWIFT_BRANCH_SPEC%==5.7 (
  set REF=%PREFIX%release/5.7
) else (
  set REF=%PREFIX%main
)

endlocal && set %1=%REF%
exit /b



rem ###########################################################################
:sw_find_python <result_var>
setlocal enabledelayedexpansion

%SW_LOG_JOB_INFO% --message="Looking for Python"

call :sw_where python.exe SW_PYTHON_EXECUTABLE
for /F "tokens=* USEBACKQ" %%i in (`cygpath -m "%SW_PYTHON_EXECUTABLE%"`) do (
  set SW_PYTHON_EXECUTABLE=%%i
)
if "%SW_PYTHON_EXECUTABLE%"=="" (
  %SW_LOG_JOB_WARNING% --message="Python not found"
)
%SW_LOG_JOB_INFO% --message="Found Python executable: %SW_PYTHON_EXECUTABLE%"

call :sw_getpath "%SW_PYTHON_EXECUTABLE%" SW_PYTHON_ROOT
for /F "tokens=* USEBACKQ" %%i in (`cygpath -m "%SW_PYTHON_ROOT%\"`) do (
  set SW_PYTHON_ROOT=%%i
)

endlocal && set %1=%SW_PYTHON_ROOT%
exit /b



rem ###########################################################################
:sw_where <executable> <result_var>
set %2=%~$PATH:1
exit /b



rem ###########################################################################
:sw_getpath <file> <result_var>
SET %2=%~dp1
EXIT /b


