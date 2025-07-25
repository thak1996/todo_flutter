import 'package:todo_flutter/app/l10n/app_localizations.dart';

class Validators {
  static String? validateEmail(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) return l10n.requiredField;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return l10n.invalidEmail;
    return null;
  }

  static String? validatePassword(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) return l10n.requiredField;
    if (value.length < 8) return l10n.passwordMinLength;
    return null;
  }

  static String? validateConfirmPassword(
    String? value,
    String password,
    AppLocalizations l10n,
  ) {
    if (value == null || value.isEmpty) return l10n.requiredField;
    if (value != password) return l10n.passwordsDoNotMatch;
    return null;
  }

  static String? validateName(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) return l10n.requiredField;
    if (value.length < 3) return l10n.nameMinLength;
    return null;
  }
}
