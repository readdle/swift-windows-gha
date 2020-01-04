REM https://github.com/microsoft/vswhere/wiki/Find-VC
for /f "usebackq delims=*" %%i in (`"C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere" -latest -property installationPath`) do (
  call "%%i"\Common7\Tools\vsdevcmd.bat %*
)

setlocal
for /f "delims== tokens=1,2" %%a in ('set') do (
  echo ::set-env name=%%a::%%b
)
endlocal
