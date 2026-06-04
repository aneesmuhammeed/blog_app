class ServerException implements Exception {
  final String message;
  //stack trace, status code can be added
  const ServerException(this.message);
}
