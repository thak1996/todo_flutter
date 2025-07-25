import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/app/core/exceptions/app.exception.dart';
import 'package:todo_flutter/app/core/models/todo.model.dart';
import 'package:todo_flutter/app/core/models/user.model.dart';
import 'package:todo_flutter/app/core/routes/app.router.dart';
import 'package:todo_flutter/app/core/service/auth.service.dart';
import 'package:todo_flutter/app/core/service/todo.service.dart';
import 'home.state.dart';

class HomeController extends Cubit<HomeState> {
  HomeController(this._authService, this._todoService) : super(HomeInitial());

  final AuthService _authService;
  final TodoService _todoService;

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

  Future<void> getTodos() async {
    emit(HomeLoading());
    final firebaseUser = _authService.currentUser;
    if (firebaseUser == null) {
      emit(HomeError(AppException.notFound()));
      return;
    }
    final result = await _todoService.getTodos(firebaseUser.uid.toString());
    result.fold(
      (todos) => emit(HomeTodosLoaded(todos)),
      (error) => emit(HomeError(AppException.notFound())),
    );
  }

  Future<void> addTodo(TodoModel todo) async {
    emit(HomeLoading());
    final result = await _todoService.addTodo(todo);
    result.fold((todo) {
      getTodos();
      emit(HomeTodoCreated(todo));
    }, (error) => emit(HomeError(AppException.notFound())));
  }
}
