class AppException implements Exception {
  AppException([
    this.message = '',
    this.responseCode = 200,
  ]);

  final String message;
  final int responseCode;
}
