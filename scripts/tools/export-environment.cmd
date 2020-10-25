:: Build script has global environment and needs no special handling of environment variables
if "%SW_BUILD_ENVIRONMENT%"=="script" goto :eof

:: No sense to try GitHub Actions Workflow command when running outside of Github Actions
if not defined GITHUB_ACTIONS goto :eof

set>%GITHUB_ENV%
