%SW_LOG_JOB_INFO% --message="Configuring curl..."

cmake^
 -B %SW_CURL_BUILD_DIR%^
 -D BUILD_SHARED_LIBS=NO^
 -D CMAKE_BUILD_TYPE=Release^
 -D CMAKE_C_COMPILER=cl^
 -D CMAKE_C_FLAGS="/GS- /Oy /Gw /Gy"^
 -D CMAKE_CXX_COMPILER=cl^
 -D CMAKE_CXX_FLGS="/GS- /Oy /Gw /Gy"^
 -D CMAKE_MT=mt^
 -D CMAKE_INSTALL_PREFIX=%SW_CURL_INSTALL_DIR%^
 -G Ninja^
 -S %SW_CURL_SOURCES_DIR%^
 -D BUILD_TESTING=NO^
 -D BUILD_CURL_EXE=NO^
 -D CURL_USE_OPENSSL=NO^
 -D CURL_CA_PATH=none^
 -D CURL_USE_SCHANNEL=YES^
 -D CURL_USE_LIBSSH2=NO^
 -D HAVE_POLL_FINE=NO^
 -D CURL_DISABLE_LDAP=YES^
 -D CURL_DISABLE_LDAPS=YES^
 -D CURL_DISABLE_TELNET=YES^
 -D CURL_DISABLE_DICT=YES^
 -D CURL_DISABLE_FILE=YES^
 -D CURL_DISABLE_TFTP=YES^
 -D CURL_DISABLE_RTSP=YES^
 -D CURL_DISABLE_PROXY=YES^
 -D CURL_DISABLE_POP3=YES^
 -D CURL_DISABLE_IMAP=YES^
 -D CURL_DISABLE_SMTP=YES^
 -D CURL_DISABLE_GOPHER=YES^
 -D CURL_DISABLE_MQTT=YES^
 -D CURL_DISABLE_SMB=YES^
 -D CURL_ZLIB=YES^
 -D ENABLE_UNIX_SOCKETS=NO^
 -D ENABLE_THREADED_RESOLVER=NO^
 -D ZLIB_ROOT=%SW_ZLIB_DIR%/usr^
 -D ZLIB_LIBRARY=%SW_ZLIB_DIR%/usr/lib/zlibstatic.lib
