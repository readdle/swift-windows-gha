setlocal

set SW_PUSHDIR=%CD%

if %SW_ICU_VERSION% leq 64 (
  cd /d %SW_ICU_SOURCES_DIR%^
   && git config user.name 'builder'^
   && git config user.email 'builder@lxbndr.org'^
   && git apply %SW_WORKSPACE%\patch\icu\e5381c956b73b236c5d7866b2a6b65f879e770ea.patch
) else (
  cd /d %SW_ICU_SOURCES_DIR%^
   && git config user.name 'builder'^
   && git config user.email 'builder@lxbndr.org'^
   && git apply %SW_WORKSPACE%\patch\icu\715d254a02b0b22681cb6f861b0921ae668fa7d6.patch
)

set SW_ERROR=%ERRORLEVEL%
cd /d %SW_PUSHDIR%

endlocal & exit /b %SW_ERROR%
