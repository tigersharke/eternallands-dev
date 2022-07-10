--- socket.cpp.orig	2022-07-09 23:49:58 UTC
+++ socket.cpp
@@ -179,7 +179,7 @@ size_t TCPSocket::send(const std::uint8_t* data, size_
 		std::lock_guard<std::mutex> guard(_ssl_mutex);
 		ERR_clear_error();
 // OpenSSL prior to 1.1.1 does not have SSL_write_ex()
-#if OPENSSL_VERSION_NUMBER >= 0x1010100f
+#if OPENSSL_VERSION_NUMBER >= 0x1010100f && !defined(LIBRESSL_VERSION_NUMBER)
 		int ret = SSL_write_ex(_ssl, data, data_len, &nr_bytes_sent);
 		if (!ret)
 		{
@@ -264,7 +264,7 @@ size_t TCPSocket::receive_or_peek(std::uint8_t* buffer
 		std::lock_guard<std::mutex> guard(_ssl_mutex);
 		ERR_clear_error();
 // OpenSSL prior to 1.1.1 does not have SSL_read_ex()
-#if OPENSSL_VERSION_NUMBER >= 0x1010100f
+#if OPENSSL_VERSION_NUMBER >= 0x1010100f && !defined(LIBRESSL_VERSION_NUMBER)
 		size_t nr_bytes;
 		int ret = SSL_read_ex(_ssl, buffer, max_len, &nr_bytes);
 		if (!ret)
