setlocal enabledelayedexpansion

%SW_PRE_STEP% --scope="sdk" --name="Configure llvm" --flag=SW_SKIP_SDK_RUNTIME
if errorlevel 1 exit /b 0

cmake^
 -B %SW_LLVM_BUILD_DIR%^
 -D CMAKE_BUILD_TYPE=Release^
 -D CMAKE_C_COMPILER=cl^
 -D CMAKE_C_FLAGS="/GS- /Oy /Gw /Gy"^
 -D CMAKE_CXX_COMPILER=cl^
 -D CMAKE_CXX_FLAGS="/GS- /Oy /Gw /Gy"^
 -D CMAKE_MT=mt^
 -D CMAKE_INSTALL_PREFIX=%SW_SDK_INSTALL_DIR%^
 -D CMAKE_SYSTEM_NAME=Windows^
 -D CMAKE_SYSTEM_PROCESSOR=%SW_ARCH%^
 -G Ninja^
 -S %SW_LLVM_PROJECT_SOURCES_DIR%\llvm^
 -D LLVM_ENABLE_ASSERTIONS=NO
 
endlocal
