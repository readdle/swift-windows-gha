if defined VSCMD_VER goto :eof

REM https://github.com/microsoft/vswhere/wiki/Find-VC
for /f "usebackq delims=*" %%i in (`"C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere" -latest -property installationPath`) do (
    call "%%i"\Common7\Tools\vsdevcmd.bat %*
)

if "%SW_BUILD_ENVIRONMENT%"=="script" goto :eof

if not defined GITHUB_ACTIONS goto :eof

set>%GITHUB_ENV%
