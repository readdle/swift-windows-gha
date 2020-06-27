setlocal enabledelayedexpansion

set SW_FREE_DRIVE=
for %%l in (K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z) do (
    set SW_DRIVE=%%l:
    subst !SW_DRIVE! %SystemDrive%\ >nul
    if not errorlevel 1 (
        subst !SW_DRIVE! /d >nul
        set SW_FREE_DRIVE=!SW_DRIVE!
        goto :eof
    )
)

endlocal & set SW_FREE_DRIVE=%SW_FREE_DRIVE%
