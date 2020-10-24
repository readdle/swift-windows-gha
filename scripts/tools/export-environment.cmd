:: No sense to try GitHub Actions Workflow command when running outside of Github Actions
if not defined GITHUB_ACTIONS goto :eof

set>%GITHUB_ENV%
