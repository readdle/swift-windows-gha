setlocal enabledelayedexpansion

%SW_LOG_JOB_INFO% --message="Installing ICU tools..."

set SW_ICU_TOOLS_INSTALL_DIR=%SW_INSTALL_DIR%\icu-tools-%SW_ICU_VERSION%

mkdir %SW_ICU_TOOLS_INSTALL_DIR%^
 && copy %SW_ICU_TOOLS_BUILD_DIR%\genbrk.exe %SW_ICU_TOOLS_INSTALL_DIR%^
 && copy %SW_ICU_TOOLS_BUILD_DIR%\gencfu.exe %SW_ICU_TOOLS_INSTALL_DIR%^
 && copy %SW_ICU_TOOLS_BUILD_DIR%\gencnval.exe %SW_ICU_TOOLS_INSTALL_DIR%^
 && copy %SW_ICU_TOOLS_BUILD_DIR%\gendict.exe %SW_ICU_TOOLS_INSTALL_DIR%^
 && copy %SW_ICU_TOOLS_BUILD_DIR%\genrb.exe %SW_ICU_TOOLS_INSTALL_DIR%^
 && copy %SW_ICU_TOOLS_BUILD_DIR%\gensprep.exe %SW_ICU_TOOLS_INSTALL_DIR%^
 && copy %SW_ICU_TOOLS_BUILD_DIR%\icupkg.exe %SW_ICU_TOOLS_INSTALL_DIR%^
 && copy %SW_ICU_TOOLS_BUILD_DIR%\makeconv.exe %SW_ICU_TOOLS_INSTALL_DIR%^
 && copy %SW_ICU_TOOLS_BUILD_DIR%\pkgdata.exe %SW_ICU_TOOLS_INSTALL_DIR%

endlocal