import 'package:todo_flutter/app/core/exceptions/base.exception.dart';

extension ExceptionExtension on Exception {
  String get userMessage {
    return switch (this) {
      BaseException() => (this as BaseException).userMessage,
      _ => 'Erro inesperado: ${toString()}',
    };
  }
}
