import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/app/core/exceptions/app.exception.dart';
import 'package:todo_flutter/app/core/models/user.model.dart';
import 'package:todo_flutter/app/core/routes/app.router.dart';
import 'package:todo_flutter/app/core/service/auth.service.dart';
import 'home.state.dart';

class HomeController extends Cubit<HomeState> {
  HomeController(this._authService) : super(HomeInitial());

  final AuthService _authService;

  Future<UserModel?> loadUser() async {
    emit(HomeLoading());
    final user = await UserModel.loadFromSecureStorage();
    if (user == null || !user.hasEssentialData) {
      final firebaseUser = _authService.currentUser;
      if (firebaseUser != null) {
        final user = UserModel(
          uid: firebaseUser.uid,
          email: firebaseUser.email,
          name: firebaseUser.displayName,
        );
        await user.saveToSecureStorage();
        emit(HomeLoaded(user));
      } else {
        emit(HomeError(AppException.notFound()));
        return null;
      }
    } else {
      emit(HomeLoaded(user));
      return user;
    }
    return null;
  }

  Future<void> logout() async {
    emit(HomeLoading());
    try {
      final user = await UserModel.loadFromSecureStorage();
      if (user != null) {
        await user.deleteFromSecureStorage();
        await _authService.signOut();
        await authNotifier.logout();
      }
    } catch (e) {
      emit(HomeError(AppException.unknown()));
    }
  }
}
