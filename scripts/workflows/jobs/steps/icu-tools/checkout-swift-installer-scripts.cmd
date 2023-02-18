%SW_LOG_JOB_INFO% --message="Fetching swift-installer-scripts..."
call scripts\tools\checkout.cmd --url=https://github.com/apple/swift-installer-scripts --dir=%SW_SWIFT_INSTALLER_SCRIPTS_SOURCES_DIR% --ref=%SW_SWIFT_INSTALLER_SCRIPTS_REF% --depth=1
