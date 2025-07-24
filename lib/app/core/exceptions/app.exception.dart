abstract class AppException implements Exception {
  final String message;
  final String code;

  const AppException(this.message, this.code);

  String get userMessage => message;

  @override
  String toString() => message;
}

extension ExceptionExtension on Exception {
  String get userMessage {
    return switch (this) {
      AppException() => (this as AppException).userMessage,
      _ => 'Erro inesperado: ${toString()}',
    };
  }
}
