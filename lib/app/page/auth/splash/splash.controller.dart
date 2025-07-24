import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/app/core/models/user.model.dart';
import 'splash.state.dart';

class SplashController extends Cubit<SplashState> {
  SplashController() : super(SplashInitial());

  Future<void> checkUserAuthentication() async {
    emit(SplashLoading());
    await Future.delayed(const Duration(seconds: 2));
    try {
      final isValid = await UserModel.areSavedDataValid();
      if (isValid) {
        emit(SplashAuthenticated());
      } else {
        emit(SplashUnauthenticated());
      }
    } catch (e) {
      emit(SplashUnauthenticated());
    }
  }
}
