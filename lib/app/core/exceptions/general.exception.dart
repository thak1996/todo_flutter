import 'base.exception.dart';

class GeneralException extends BaseException {
  const GeneralException(super.message, super.code);

  factory GeneralException.unexpected([String? details]) => GeneralException(
    'Erro inesperado${details != null ? ': $details' : ''}',
    'unexpected-error',
  );

  factory GeneralException.notFound(String resource) =>
      GeneralException('$resource não encontrado', 'not-found');

  factory GeneralException.validation(String field) =>
      GeneralException('$field é obrigatório', 'validation-error');

  factory GeneralException.permission() => const GeneralException(
    'Sem permissão para esta operação',
    'permission-denied',
  );

  factory GeneralException.network() =>
      const GeneralException('Erro de conexão com a internet', 'network-error');
}
