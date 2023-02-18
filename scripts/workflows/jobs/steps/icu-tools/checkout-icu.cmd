%SW_LOG_JOB_INFO% --message="Fetching unicode-org/icu..."
call scripts\tools\checkout.cmd --url=https://github.com/unicode-org/icu --dir=%SW_ICU_SOURCES_DIR% --ref=%SW_ICU_REF% --depth=1
