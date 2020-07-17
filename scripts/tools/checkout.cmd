@echo off

setlocal enabledelayedexpansion

rem *** Parse input arguments
:sw_parse_argument
set CURRENT_ARG=%1
if [%CURRENT_ARG%]==[] goto sw_parse_argumens_end

if [%NEXT_ARG%]==[SW_URL] goto sw_parse_argument_accept
if [%NEXT_ARG%]==[SW_REF] goto sw_parse_argument_accept
if [%NEXT_ARG%]==[SW_TARGET_DIR] goto sw_parse_argument_accept
if [%NEXT_ARG%]==[SW_FETCH_DEPTH] goto sw_parse_argument_accept

if [%CURRENT_ARG%]==[--url] set NEXT_ARG=SW_URL
if [%CURRENT_ARG%]==[--ref] set NEXT_ARG=SW_REF
if [%CURRENT_ARG%]==[--depth] set NEXT_ARG=SW_FETCH_DEPTH
if [%CURRENT_ARG%]==[--dir] set NEXT_ARG=SW_TARGET_DIR
if [%CURRENT_ARG%]==[--help] goto help
goto :sw_parse_argument_next

:sw_parse_argument_accept
set %NEXT_ARG%=%CURRENT_ARG%
set NEXT_ARG=

:sw_parse_argument_next
shift
goto sw_parse_argument
:sw_parse_argumens_end


rem *** Remember current directory to restore in :finalize
set SW_PUSHDIR=%CD%


rem *** Check and preprocess ref.
rem     If ref parameter is exactly 40 characters long and consists 
rem     only hex digits, it is considered as commit hash.
if [%SW_REF%]==[] set SW_REF=master
echo.%SW_REF%| findstr /r /c:"^[0-9a-fA-F]*$" >nul 2>&1
if not errorlevel 1 (
  echo %SW_REF%> ref.tmp& for %%? in (ref.tmp) do set /a SW_STRLEN=%%~z? - 2 & del ref.tmp
  if not [!SW_STRLEN!]==[] (
    if !SW_STRLEN! equ 40 (
      set SW_COMMIT=%SW_REF%
      set SW_REF=
    )
  )
)


rem *** Check input parameters
if [%SW_URL%]==[] (
  echo Repository URL not specified
  set SW_ERROR=1
  goto finalize
)
if [%SW_TARGET_DIR%]==[] (
  echo Target directory not specified
  set SW_ERROR=1
  goto finalize
)
if not [%SW_FETCH_DEPTH%]==[] (
  echo %SW_FETCH_DEPTH%| findstr /r "^[1-9][0-9]*$">nul
  if errorlevel 1 (
    echo Invalid depth parameter: %SW_FETCH_DEPTH%
    set SW_ERROR=1
    goto finalize
  )
)


echo Repository URL:    %SW_URL%
echo Ref:               %SW_REF%
echo Commit:            %SW_COMMIT%
echo Depth:             %SW_FETCH_DEPTH%
echo Target directory:  %SW_TARGET_DIR%
echo.


set SW_TAGS_REF_SPEC=+refs/tags/*:refs/tags/*


rem *** Check target directory
if exist %SW_TARGET_DIR% (
  for /f "delims=" %%a in ('dir /a /b %SW_TARGET_DIR%') do set SW_LAST_DIR_ITEM=%%a
  if not [!SW_LAST_DIR_ITEM!]==[] (
    echo Target directory not empty
    set SW_ERROR=2
    goto finalize
  )
)


rem *** Initialize repository
git init %SW_TARGET_DIR%
if errorlevel 1 (
  set SW_ERROR=1
  goto finalize
)


rem *** Go into repository directory
cd /d %SW_TARGET_DIR%
if errorlevel 1 (
  set SW_ERROR=1
  goto finalize
)


rem *** Add remote URL
git remote add origin %SW_URL%
if errorlevel 1 (
  set SW_ERROR=1
  goto finalize
)


rem *** Disable automatic garbage collection
git config gc.auto 0


rem *** Fetch repository
if not defined SW_FETCH_DEPTH (
  call :get_ref_spec_all_history SW_REF_SPEC "%SW_REF%" "%SW_COMMIT%"
  call :git_fetch "!SW_REF_SPEC!"
  rem todo: implement testRef
) else (
  call :get_ref_spec SW_REF_SPEC "%SW_REF%" "%SW_COMMIT%"
  call :git_fetch "!SW_REF_SPEC!" "%SW_FETCH_DEPTH%"
)


rem *** Get checkout info
call :get_checkout_info SW_REF SW_START_POINT "%SW_REF%" "%SW_COMMIT%"
if errorlevel 1 (
  set SW_ERROR=%ERRORLEVEL%
  goto finalize
)


rem *** Checkout
call :git_checkout "%SW_REF%" "%SW_START_POINT%"
if errorlevel 1 (
  set SW_ERROR=%ERRORLEVEL%
)


goto finalize


rem ###########################################################################
:get_ref_spec_all_history <result_var> <ref> <commit>
setlocal enabledelayedexpansion

set REF=%~2
set COMMIT=%~3

set REF_SPEC=+refs/heads/*:refs/remotes/origin/* %SW_TAGS_REF_SPEC%
if /i "%REF:~0,10%"=="refs/pull/" (
  set BRANCH=%REF:~10%
  if not [%COMMIT%]==[] (
    set COMMIT_OR_REF=%COMMIT%
  ) else (
    set COMMIT_OR_REF=%REF%
  )
  set REF_SPEC=!REF_SPEC! +!COMMIT_OR_REF!:refs/remotes/pull/!BRANCH!
)
(
  endlocal
  set %1=%REF_SPEC%
  exit /b
)


rem ###########################################################################
:get_ref_spec <result_var> <ref> <commit>
setlocal enabledelayedexpansion

set REF=%~2
set COMMIT=%~3

if defined COMMIT (
  if /i "%REF:~0,11%"=="refs/heads/" (
    set BRANCH=%REF:~11%
    set REF_SPEC=+%COMMIT%:refs/remotes/origin/!BRANCH!
  ) else if /i "%REF:~0,10%"=="refs/pull/" (
    set BRANCH=%REF:~10%
    set REF_SPEC=+%COMMIT%:refs/remotes/pull/!BRANCH!
  ) else if /i "%REF:~0,10%"=="refs/tags/" (
    set REF_SPEC=+%COMMIT%:%REF%
  ) else (
    set REF_SPEC=%COMMIT%
  )
) else if /i not "%REF:~0,5%"=="refs/" (
  set REF_SPEC=+refs/heads/%REF%*:refs/remotes/origin/%REF%* +refs/tags/%REF%*:refs/tags/%REF%*
) else if /i "%REF:~0,11%"=="refs/heads/" (
  set BRANCH=%REF:~11%
  set REF_SPEC=+%REF%:refs/remotes/origin/!BRANCH!
) else if /i "%REF:~0,10%"=="refs/pull/" (
  set BRANCH=%REF:~10%
  set REF_SPEC=+%REF%:refs/remotes/pull/!BRANCH!
) else (
  set REF_SPEC=+%REF%:%REF%
)

( 
  endlocal
  set %1=%REF_SPEC%
  exit /b
)


rem ###########################################################################
:git_fetch <ref_spec> <fetch_depth>
setlocal enabledelayedexpansion

set REF_SPEC=%~1
set FETCH_DEPTH=%~2

set GIT_ARGS=-c protocol.version=2 fetch

echo %REF_SPEC%| findstr %SW_TAGS_REF_SPEC%>nul
if not errorlevel 1 (
  set GIT_ARGS=%GIT_ARGS% --no-tags
)

set GIT_ARGS=%GIT_ARGS% --prune --progress --no-recurse-submodules

if defined FETCH_DEPTH (
  set GIT_ARGS=%GIT_ARGS% --depth=%FETCH_DEPTH%
)

set GIT_ARGS=%GIT_ARGS% origin %REF_SPEC%
echo %GIT_ARGS%

git %GIT_ARGS%

( 
  endlocal
  exit /b %ERRORLEVEL%
)


rem ###########################################################################
:get_checkout_info <ref_result_var> <start_point_result_var> <ref> <commit>
setlocal enabledelayedexpansion

set REF=%~3
set COMMIT=%~4

if not defined REF if not defined COMMIT ( 
  endlocal
  exit /b 1
)

if not defined REF (
  set RESULT_REF=%COMMIT%
) else if /i "%REF:~0,11%"=="refs/heads/" (
  set BRANCH=%REF:~11%
  set RESULT_REF=!BRANCH!
  set RESULT_START_POINT=refs/remotes/origin/!BRANCH!
) else if /i "%REF:~0,10%"=="refs/pull/" (
  set BRANCH=%REF:~10%
  set RESULT_REF=refs/remotes/pull/!BRANCH!
) else if /i "%REF:~0,5%"=="refs/" (
  set RESULT_REF=%REF%
) else (
  call :branch_exists BRANCH_EXISTS YES origin/%REF%
  if [!BRANCH_EXISTS!]==[YES] (
    set RESULT_REF=%REF%
    set RESULT_START_POINT=refs/remotes/origin/%REF%  
  ) else (
    call :tag_exists TAG_EXISTS %REF%
    if [!TAG_EXISTS!]==[YES] (
      set RESULT_REF=refs/tags/%REF%
    ) else (
      echo A branch or tag with the name '%REF%' could not be found
      endlocal
      exit /b 1
    )
  )
)

( 
  endlocal
  set %1=%RESULT_REF%
  set %2=%RESULT_START_POINT%
  exit /b
)


rem ###########################################################################
:branch_exists <result_var> <is_remote> <pattern>
setlocal enabledelayedexpansion

set IS_REMOTE=%2
set PATTERN=%3

set GIT_ARGS=branch --list
if /i [%IS_REMOTE%]==[YES] (
  set GIT_ARGS=%GIT_ARGS% --remote
)

set GIT_ARGS=%GIT_ARGS% %PATTERN%

git %GIT_ARGS%| findstr /r /c:".*"> nul
if errorlevel 1 ( 
  set RESULT=NO
) else (
  set RESULT=YES
)

( 
  endlocal
  set %1=%RESULT%
  exit /b
)


rem ###########################################################################
:tag_exists <result_var> <tag>
setlocal enabledelayedexpansion

set PATTERN=%2

git tag --list %PATTERN%| findstr /r /c:".*"> nul
if errorlevel 1 ( 
  set RESULT=NO
) else (
  set RESULT=YES
)

( 
  endlocal
  set %1=%RESULT%
  exit /b
)


rem ###########################################################################
:git_checkout <ref> <start_point>
setlocal enabledelayedexpansion

set REF=%~1
set START_POINT=%~2

set GIT_ARGS=checkout --progress --force
if defined START_POINT (
  set GIT_ARGS=%GIT_ARGS% -B %REF% %START_POINT%
) else (
  set GIT_ARGS=%GIT_ARGS% %REF%
)

git %GIT_ARGS%
( 
  endlocal
  exit /b %ERRORLEVEL%
)


rem ###########################################################################
:help
echo Fetches and checkouts git repository. Does not handle authorization.
echo.
echo Parameters:
echo.  --url=^<value^>      Git repository URL
echo.  --dir=^<value^>      Directory to fetch into
echo.  --ref=^<value^>      Tag, branch or commit hash. Optional.
echo.  --depth=^<value^>    Fetch depth. A number greater than 0. Optional.
echo.  --help             Display this help message
(
  endlocal
  exit /b
)

rem ###########################################################################
:finalize
rem *** Restore original working directory
cd /d %SW_PUSHDIR%


(
  endlocal
  exit /b %SW_ERROR%
)
