// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get titleApp => 'Todo App';

  @override
  String get welcomeBack => 'Welcome Back!';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get login => 'login';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get signUp => 'Sign Up';

  @override
  String get requiredField => 'Required Field';

  @override
  String get invalidEmail => 'Invalid E-mail';

  @override
  String get passwordMinLength => 'Password must be at least 8 characters long';

  @override
  String get switchToDarkMode => 'Dark Mode';

  @override
  String get switchToLightMode => 'Light Mode';

  @override
  String get createAccount => 'Criar Conta';

  @override
  String get name => 'Nome';

  @override
  String get alreadyHaveAccount => 'Já tem uma conta?';

  @override
  String get passwordsDoNotMatch => 'Passowrds do Not Match';

  @override
  String get confirmPassword => ' Confirm Password';

  @override
  String get register => 'Register';

  @override
  String get nameMinLength => 'Name required 3 characters';

  @override
  String get errorNotFound => 'Resource not found';

  @override
  String get errorUnauthorized => 'Unauthorized access';

  @override
  String get errorNetwork => 'Network error';

  @override
  String get errorValidation => 'Invalid data';

  @override
  String get errorUnknown => 'Unknown error';
}
