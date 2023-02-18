if defined VSCMD_VER goto :eof

REM https://github.com/microsoft/vswhere/wiki/Find-VC
for /f "usebackq delims=*" %%i in (`"C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere" -products * -latest -property installationPath`) do (
    call "%%i"\Common7\Tools\vsdevcmd.bat %*
    exit /b
)
