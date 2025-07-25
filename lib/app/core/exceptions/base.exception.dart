abstract class BaseException implements Exception {
  final String message;
  final String code;

  const BaseException(this.message, this.code);

  String get userMessage => message;

  @override
  String toString() => message;
}
