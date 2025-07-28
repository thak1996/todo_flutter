import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/app/core/exceptions/app.exception.dart';
import 'package:todo_flutter/app/core/models/todo.model.dart';
import 'package:todo_flutter/app/core/models/user.model.dart';
import 'package:todo_flutter/app/core/routes/app.router.dart';
import 'package:todo_flutter/app/core/service/auth.service.dart';
import 'package:todo_flutter/app/core/service/group.service.dart';
import 'package:todo_flutter/app/core/service/todo.service.dart';
import 'home.state.dart';

class HomeController extends Cubit<HomeState> {
  HomeController(this._authService, this._todoService, this._groupService)
    : super(HomeInitial()) {
    loadUser();
    getTodos();
  }

  final AuthService _authService;
  final TodoService _todoService;
  final GroupService _groupService;

  UserModel? _currentUser;

  AuthService get authService => _authService;
  UserModel? get currentUser => _currentUser;

  Future<UserModel?> loadUser() async {
    emit(HomeLoading());
    final user = await _getValidUser();
    _currentUser = user;
    emit(HomeUserLoaded(user));
    return user;
  }

  Future<void> logout() async {
    emit(HomeLoading());
    try {
      final user = await _getValidUser();
      await user.deleteFromSecureStorage();
      await _authService.signOut();
      await authNotifier.logout();
    } catch (e) {
      emit(HomeError(AppException.unknown()));
    }
  }

  Future<void> getTodos() async {
    emit(HomeLoading());
    final user = await _getValidUser();
    final result = await _todoService.getTodos(user.uid.toString());
    result.fold(
      (todos) => emit(HomeTodoLoaded(todos)),
      (error) => emit(HomeError(AppException.notFound())),
    );
  }

  Future<void> addTodo(TodoModel todo) async {
    emit(HomeLoading());
    final result = await _todoService.addTodo(todo);
    result.fold(
      (todo) async => await getTodos(),
      (error) => emit(HomeError(AppException.notFound())),
    );
  }

  Future<void> getUserGroups() async {
    emit(HomeLoading());
    final user = await _getValidUser();
    final result = await _groupService.getGroupsByUser(user.uid.toString());
    result.fold(
      (groups) => emit(HomeGroupsLoaded(groups)),
      (error) => emit(HomeError(AppException.notFound())),
    );
  }

  Future<UserModel> _getValidUser() async {
    UserModel? user = await UserModel.loadFromSecureStorage();
    if (user == null || user.name == null || user.name!.isEmpty) {
      final firebaseUser = _authService.currentUser;
      if (firebaseUser != null) {
        user = UserModel(
          uid: firebaseUser.uid,
          email: firebaseUser.email,
          name: firebaseUser.displayName,
        );
        await user.saveToSecureStorage();
      } else {
        throw AppException.userNotFound();
      }
    }
    return user;
  }
}
