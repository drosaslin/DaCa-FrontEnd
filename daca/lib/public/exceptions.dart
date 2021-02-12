class InvalidCredentialsException implements Exception {
  final String message;

  const InvalidCredentialsException(this.message);
}

class InvalidParametersException implements Exception {
  final String message;

  const InvalidParametersException(this.message);
}

class ConnectionException implements Exception {
  final String message;

  const ConnectionException(this.message);
}
