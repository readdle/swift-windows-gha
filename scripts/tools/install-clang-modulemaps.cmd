@echo off
setlocal enabledelayedexpansion

if not defined VSCMD_VER (
    echo Please run from Developer Command Prompt ^(Elevated^)
    exit /b 1
)

whoami /groups | findstr /c:" S-1-5-32-544 " | findstr /c:" Enabled group">nul
if errorlevel 1 (
    echo Please run from Developer Command Prompt ^(Elevated^)
    exit /b 1
)

set "SW_CURRENT_DIR=%~dp0"

if exist "%SW_CURRENT_DIR%\ucrt.modulemap" copy "%SW_CURRENT_DIR%\ucrt.modulemap" "%UniversalCRTSdkDir%\Include\%UCRTVersion%\ucrt\module.modulemap"
if exist "%SW_CURRENT_DIR%\winsdk.modulemap" copy "%SW_CURRENT_DIR%\winsdk.modulemap" "%UniversalCRTSdkDir%\Include\%UCRTVersion%\um\module.modulemap"
if exist "%SW_CURRENT_DIR%\visualc.modulemap" copy "%SW_CURRENT_DIR%\visualc.modulemap" "%VCToolsInstallDir%\include\module.modulemap"
if exist "%SW_CURRENT_DIR%\visualc.apinotes" copy "%SW_CURRENT_DIR%\visualc.apinotes" "%VCToolsInstallDir%\include\visualc.apinotes"

echo Done

endlocal
