import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/app/core/routes/app.router.dart';
import '../../../core/models/user.model.dart';
import 'login.state.dart';

class LoginController extends Cubit<LoginState> {
  LoginController() : super(const LoginInitial());

  void validateFields(UserModel userModel) {
    final isValid = userModel.isValidLogin;
    emit(LoginInitial(isValid: isValid));
  }

  Future<void> login(UserModel userModel) async {
    emit(const LoginLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      if (userModel.email == 'teste@teste.com' &&
          userModel.password == 'senha123') {
        userModel = userModel.copyWith(uid: '12345678');
        await userModel.saveToSecureStorage();
        await authNotifier.login();
        emit(LoginSuccess());
      } else {
        emit(const LoginError('E-mail ou senha incorretos.'));
        return;
      }
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
