%SW_LOG_JOB_INFO% --message="Fetching swift..."
call scripts\tools\checkout.cmd --url=https://github.com/apple/swift --dir=%SW_SWIFT_SOURCES_DIR% --ref=%SW_SWIFT_REF% --depth=1
