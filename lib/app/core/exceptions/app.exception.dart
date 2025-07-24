abstract class AppException implements Exception {
  final String message;
  final String code;

  const AppException(this.message, this.code);

  String get userMessage => message;

  @override
  String toString() => message;
}
