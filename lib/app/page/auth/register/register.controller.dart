import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/app/core/extension/exception.extension.dart';
import 'package:todo_flutter/app/core/models/user.model.dart';
import 'package:todo_flutter/app/core/routes/app.router.dart';
import 'package:todo_flutter/app/core/service/auth.service.dart';
import 'register.state.dart';

class RegisterController extends Cubit<RegisterState> {
  RegisterController(this.authService) : super(RegisterInitial());

  final AuthService authService;

  void validateFields(UserModel userModel) {
    final isValid = userModel.isValidRegister;
    emit(RegisterInitial(isValid: isValid));
  }

  Future<void> register(UserModel userModel) async {
    emit(RegisterLoading());
    final result = await authService.createUserWithEmailAndPassword(
      email: userModel.email!,
      password: userModel.password!,
      name: userModel.name!,
      photoUrl: userModel.photoUrl!,
    );
    result.fold((onSuccess) async {
      await userModel.saveToSecureStorage();
      await authNotifier.login();
      emit(RegisterSuccess());
    }, (onFailure) => emit(RegisterError(onFailure.userMessage)));
  }
}
