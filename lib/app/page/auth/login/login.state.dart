sealed class LoginState {
  final bool isValid;

  const LoginState({this.isValid = false});
}

class LoginInitial extends LoginState {
  const LoginInitial({super.isValid});
}

class LoginLoading extends LoginState {
  const LoginLoading() : super(isValid: false);
}

class LoginSuccess extends LoginState {
  const LoginSuccess() : super(isValid: false);
}

class LoginError extends LoginState {
  const LoginError(this.message) : super(isValid: false);

  final String message;
}
