%SW_LOG_JOB_INFO% --message="Fetching swift-syntax..."
call scripts\tools\checkout.cmd --url=https://github.com/apple/swift-syntax --dir=%SW_SWIFT_SYNTAX_SOURCES_DIR% --ref=%SW_SWIFT_SYNTAX_REF% --depth=1
