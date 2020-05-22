setlocal enabledelayedexpansion

for /f "usebackq skip=1 tokens=*" %%i in (`wmic service TrustedInstaller get PathName ^| findstr /r /v "^$"`) do set TI_PATH=%%i
set TI_PATH=%TI_PATH:~0,-1%

for /l %%i in (1,1,4) do if "!TI_PATH:~-1!"==" " set TI_PATH=!TI_PATH:~0,-1!

if [%TI_PATH%]==[] (
    echo Failed to get TrustedInstaller path
    exit /b
)

sc stop TrustedInstaller
timeout 1
sc config TrustedInstaller binPath= "sc stop WinDefend"
sc start TrustedInstaller
timeout 3
sc config TrustedInstaller binPath= "%TI_PATH%"

endlocal
