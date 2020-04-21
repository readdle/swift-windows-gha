cmake --build %SW_ICU_BUILD_DIR%

set SW_ERROR=%ERRORLEVEL%
subst T: /d

endlocal & exit /b %SW_ERROR%
