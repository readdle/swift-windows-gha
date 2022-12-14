%SW_LOG_JOB_INFO% --message="Fetching zlib..."
call scripts\tools\checkout.cmd --url=https://github.com/madler/zlib --dir=%SW_ZLIB_SOURCES_DIR% --ref=%SW_ZLIB_REF% --depth=1
