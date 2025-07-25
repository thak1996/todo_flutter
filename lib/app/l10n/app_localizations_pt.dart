// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get titleApp => ' Aplicativo de Tarefas';

  @override
  String get welcomeBack => 'Bem vindo de volta!';

  @override
  String get email => 'Email';

  @override
  String get password => 'Senha';

  @override
  String get forgotPassword => 'Esqueceu a senha?';

  @override
  String get login => 'Entrar';

  @override
  String get dontHaveAccount => 'Não tem conta?';

  @override
  String get signUp => 'Registrar';

  @override
  String get requiredField => 'Campo obrigatório';

  @override
  String get invalidEmail => 'E-mail Inválido';

  @override
  String get passwordMinLength => 'Senha deve ter no mínimo 8 caracteres';

  @override
  String get switchToDarkMode => 'Modo Escuro';

  @override
  String get switchToLightMode => 'Modo Claro';

  @override
  String get createAccount => 'Criar Conta';

  @override
  String get name => 'Nome';

  @override
  String get alreadyHaveAccount => 'Já tem uma conta?';

  @override
  String get passwordsDoNotMatch => 'As senhas não conferem';

  @override
  String get confirmPassword => 'Confirmação de Senha';

  @override
  String get register => 'Registrar';

  @override
  String get nameMinLength => 'Nome precisa ter pelo menos 3 caracteres';
}
