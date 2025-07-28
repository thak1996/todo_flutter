import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/app/core/extension/exception.extension.dart';
import 'package:todo_flutter/app/core/models/export.models.dart';
import 'package:todo_flutter/app/core/routes/app.router.dart';
import 'package:todo_flutter/app/core/service/auth.service.dart';
import 'login.state.dart';

class LoginController extends Cubit<LoginState> {
  LoginController(this.authService) : super(const LoginInitial());

  final AuthService authService;

  void validateFields(UserModel userModel) {
    final isValid = userModel.isValidLogin;
    emit(LoginInitial(isValid: isValid));
  }

  Future<void> login(UserModel userModel) async {
    emit(const LoginLoading());
    final result = await authService.signInWithEmailAndPassword(
      email: userModel.email!,
      password: userModel.password!,
    );
    result.fold((onSuccess) async {
      await userModel.saveToSecureStorage();
      await authNotifier.login();
      emit(LoginSuccess());
    }, (onFailure) => emit(LoginError(onFailure.userMessage)));
  }

  Future<void> loginWithGoogle() async {
    emit(const LoginLoading());
    final result = await authService.signInWithGoogle();
    result.fold((onSuccess) async {
      await onSuccess.saveToSecureStorage();
      await authNotifier.login();
      emit(LoginSuccess());
    }, (onFailure) => emit(LoginError(onFailure.userMessage)));
  }
}
