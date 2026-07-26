sealed class BleConnectionException implements Exception {}

class BleConnectionFailedException extends BleConnectionException {
  final int statusCode;
  BleConnectionFailedException(this.statusCode);
}
//
// class MovieListOtherException extends BleConnectionException {}
//
// class MovieDetailsHttpException extends BleConnectionException {
//   final int statusCode;
//   MovieDetailsHttpException(this.statusCode);
// }
//
// class MovieDetailsOtherException extends BleConnectionException {}
