import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/app/core/models/auth/user.model.dart';
import 'home.state.dart';

class HomeController extends Cubit<HomeState> {
  HomeController() : super(HomeInitial()) {
    loadUser();
  }

  Future<UserModel?> loadUser() async {
    emit(HomeLoading());
    try {
      final user = await UserModel.loadFromSecureStorage();
      if (user != null) {
        emit(HomeLoaded(user));
      } else {
        emit(HomeError('User not found'));
      }
    } catch (e) {
      emit(HomeError('Error loading user'));
    }
    return null;
  }

  Future<void> logout() async {
    try {
      final user = await UserModel.loadFromSecureStorage();
      if (user != null) {
        await user.deleteFromSecureStorage();
      }
    } catch (e) {
      emit(HomeError('Error logging out'));
    }
  }
}
