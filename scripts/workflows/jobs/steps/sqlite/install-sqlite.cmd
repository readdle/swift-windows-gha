%SW_LOG_SQLITE_INFO% --prefix="Starting step:" --message="Install SQLite"

cmake --build %SW_SQLITE_BUILD_DIR% --target install
