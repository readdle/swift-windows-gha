%SW_LOG_JOB_INFO% --message="Fetching swift-experimental-string-processing..."
call scripts\tools\checkout.cmd --url=https://github.com/apple/swift-experimental-string-processing --dir=%SW_SWIFT_EXPERIMENTAL_STRING_PROCESSING_SOURCES_DIR% --ref=%SW_SWIFT_EXPERIMENTAL_STRING_PROCESSING_REF% --depth=1
