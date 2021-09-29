setlocal enabledelayedexpansion

set SW_LOG_PATCH_INFO=%SW_LOG_INFO% --scope patch-swift
set SW_LOG_PATCH_ERROR=%SW_LOG_ERROR% --scope patch-swift

%SW_LOG_PATCH_INFO% --message="No patches for LLVM"

rem set SW_PATCH_CMAKE_MT=%SW_WORKSPACE%\patch\llvm-project\cmake-mt-%SW_SWIFT_BRANCH_SPEC%.patch

rem %SW_LOG_PATCH_INFO% --message="Will apply %SW_PATCH_CMAKE_MT%"
rem set SW_PATCH_CMAKE_MT=git apply --verbose %SW_PATCH_CMAKE_MT%

rem set SW_PUSHDIR=%CD%

rem cd /d %SW_LLVM_PROJECT_SOURCES_DIR%^
rem  && git config user.name 'builder'^
rem  && git config user.email 'swift-builder@readdle.com'^
rem  && %SW_PATCH_CMAKE_MT%

rem set SW_ERROR=%ERRORLEVEL%
rem cd /d %SW_PUSHDIR%

endlocal & exit /b %SW_ERROR%
