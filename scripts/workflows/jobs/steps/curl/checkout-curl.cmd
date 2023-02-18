%SW_LOG_JOB_INFO% --message="Fetching curl..."
call scripts\tools\checkout.cmd --url=https://github.com/curl/curl.git --dir=%SW_CURL_SOURCES_DIR% --ref=%SW_CURL_REF% --depth=1
