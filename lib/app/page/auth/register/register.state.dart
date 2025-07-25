sealed class RegisterState {
  final bool isValid;

  const RegisterState({this.isValid = false});
}

class RegisterInitial extends RegisterState {
  RegisterInitial({super.isValid});
}

class RegisterLoading extends RegisterState {
  RegisterLoading() : super(isValid: false);
}

class RegisterSuccess extends RegisterState {
  RegisterSuccess() : super(isValid: false);
}

class RegisterError extends RegisterState {
  RegisterError(this.message) : super(isValid: false);

  final String message;
}
