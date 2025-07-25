import 'package:todo_flutter/app/l10n/app_localizations.dart';

enum AppErrorType { notFound, unauthorized, network, validation, unknown }

class AppException implements Exception {
  final AppErrorType type;
  final String? message;

  AppException(this.type, [this.message]);

  factory AppException.notFound([String? message]) =>
      AppException(AppErrorType.notFound, message);

  factory AppException.unauthorized([String? message]) =>
      AppException(AppErrorType.unauthorized, message);

  factory AppException.network([String? message]) =>
      AppException(AppErrorType.network, message);

  factory AppException.validation([String? message]) =>
      AppException(AppErrorType.validation, message);

  factory AppException.unknown([String? message]) =>
      AppException(AppErrorType.unknown, message);

  String get defaultMessage {
    switch (type) {
      case AppErrorType.notFound:
        return 'Recurso não encontrado';
      case AppErrorType.unauthorized:
        return 'Acesso não autorizado';
      case AppErrorType.network:
        return 'Erro de conexão';
      case AppErrorType.validation:
        return 'Dados inválidos';
      case AppErrorType.unknown:
        return 'Erro desconhecido';
    }
  }

  String localizedMessage(AppLocalizations l10n) {
    switch (type) {
      case AppErrorType.notFound:
        return l10n.errorNotFound;
      case AppErrorType.unauthorized:
        return l10n.errorUnauthorized;
      case AppErrorType.network:
        return l10n.errorNetwork;
      case AppErrorType.validation:
        return l10n.errorValidation;
      case AppErrorType.unknown:
        return l10n.errorUnknown;
    }
  }

  @override
  String toString() => 'AppException($type): ${message ?? defaultMessage}';
}
