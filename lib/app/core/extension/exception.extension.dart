import 'package:todo_flutter/app/core/exceptions/app.exception.dart';

extension ExceptionExtension on Exception {
  String get userMessage {
    return switch (this) {
      AppException() => (this as AppException).userMessage,
      _ => 'Erro inesperado: ${toString()}',
    };
  }
}
