%SW_LOG_JOB_INFO% --message="Fetching llvm-project..."
call scripts\tools\checkout.cmd --url=https://github.com/apple/llvm-project --dir=%SW_LLVM_PROJECT_SOURCES_DIR% --ref=%SW_LLVM_REF% --depth=1
