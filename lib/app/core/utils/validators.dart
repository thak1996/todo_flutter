class Validators {
  static String? validateEmail(
    String? value, {
    required String requiredField,
    required String invalidEmail,
    String? emailMaxLength,
  }) {
    if (value == null || value.isEmpty) return requiredField;
    if (value.length > 255) return emailMaxLength;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return invalidEmail;
    }
    return null;
  }

  static String? validatePassword(
    String? value, {
    required String requiredField,
    required String passwordMinLength,
  }) {
    if (value == null || value.isEmpty) {
      return requiredField;
    }
    if (value.length < 8) {
      return passwordMinLength;
    }
    return null;
  }

  static String? confirmPassword(
    String? value,
    String password, {
    required String requiredField,
    required String passwordsDoNotMatch,
  }) {
    if (value == null || value.isEmpty) {
      return requiredField;
    }
    if (value != password) {
      return passwordsDoNotMatch;
    }
    return null;
  }
}
