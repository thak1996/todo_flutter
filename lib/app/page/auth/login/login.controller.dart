import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/auth/user.model.dart';
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
        await userModel.saveToSecureStorage();
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
