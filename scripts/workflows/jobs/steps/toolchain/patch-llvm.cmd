setlocal enabledelayedexpansion

set SW_LOG_PATCH_INFO=%SW_LOG_INFO% --scope patch-swift
set SW_LOG_PATCH_ERROR=%SW_LOG_ERROR% --scope patch-swift

set SW_PATCH_CMAKE_MT=%SW_WORKSPACE%\patch\llvm-project\cmake-mt-%SW_SWIFT_BRANCH_SPEC%.patch

%SW_LOG_PATCH_INFO% --message="Will apply %SW_PATCH_CMAKE_MT%"
set SW_PATCH_CMAKE_MT=git apply --verbose %SW_PATCH_CMAKE_MT%

set SW_PUSHDIR=%CD%

cd /d %SW_LLVM_PROJECT_SOURCES_DIR%^
 && git config user.name 'builder'^
 && git config user.email 'swift-builder@readdle.com'^
 && %SW_PATCH_CMAKE_MT%

set SW_ERROR=%ERRORLEVEL%
cd /d %SW_PUSHDIR%

endlocal & exit /b %SW_ERROR%
