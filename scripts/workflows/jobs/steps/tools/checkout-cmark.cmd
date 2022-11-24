%SW_LOG_JOB_INFO% --message="Fetching cmark..."
call scripts\tools\checkout.cmd --url=https://github.com/apple/swift-cmark --dir=%SW_CMARK_SOURCES_DIR% --ref=%SW_CMARK_REF% --depth=1
