import 'package:todo_flutter/app/core/exceptions/base.exception.dart';

extension ExceptionExtension on Exception {
  String get userMessage {
    if (this is BaseException) {
      return (this as BaseException).displayMessage;
    }
    return 'Ocorreu um erro inesperado. Tente novamente.';
  }
}
