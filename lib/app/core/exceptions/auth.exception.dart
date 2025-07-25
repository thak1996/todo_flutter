import 'package:firebase_auth/firebase_auth.dart';
import 'base.exception.dart';

class AuthException extends BaseException {
  const AuthException(super.message, super.code);

  factory AuthException.fromFirebaseAuth(FirebaseAuthException e) {
    final message = switch (e.code) {
      'user-not-found' => 'Usuário não encontrado',
      'wrong-password' => 'Senha incorreta',
      'email-already-in-use' => 'Este email já está sendo usado',
      'weak-password' => 'A senha é muito fraca',
      'invalid-email' => 'Email inválido',
      'too-many-requests' => 'Muitas tentativas. Tente novamente mais tarde',
      'user-disabled' => 'Esta conta foi desabilitada',
      'operation-not-allowed' => 'Operação não permitida',
      'invalid-credential' => 'Credenciais inválidas',
      'network-request-failed' => 'Erro de conexão. Verifique sua internet',
      'requires-recent-login' => 'Esta operação requer login recente',
      _ => 'Erro de autenticação: ${e.message ?? 'Erro desconhecido'}',
    };

    return AuthException(message, e.code);
  }

  // Constructors nomeados para casos específicos
  factory AuthException.userNotFound() =>
      const AuthException('Usuário não encontrado', 'user-not-found');

  factory AuthException.invalidCredentials() =>
      const AuthException('Credenciais inválidas', 'invalid-credential');

  factory AuthException.networkError() =>
      const AuthException('Erro de conexão', 'network-error');
}
