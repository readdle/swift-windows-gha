%SW_LOG_JOB_INFO% --message="Fetching libxml2..."
call scripts\tools\checkout.cmd --url=https://github.com/gnome/libxml2.git --dir=%SW_XML2_SOURCES_DIR% --ref=%SW_XML2_REF% --depth=1
