import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/app/core/exceptions/app.exception.dart';
import 'package:todo_flutter/app/core/models/todo.model.dart';
import 'package:todo_flutter/app/core/models/user.model.dart';
import 'package:todo_flutter/app/core/models/group.model.dart';
import 'package:todo_flutter/app/core/service/auth.service.dart';
import 'package:todo_flutter/app/core/service/group.service.dart';
import 'package:todo_flutter/app/core/service/todo.service.dart';
import 'home.state.dart';

class HomeController extends Cubit<HomeState> {
  HomeController(this._authService, this._todoService, this._groupService)
    : super(HomeInitial()) {
    _init();
  }

  final AuthService _authService;
  final TodoService _todoService;
  final GroupService _groupService;

  UserModel? _currentUser;

  AuthService get authService => _authService;
  UserModel? get currentUser => _currentUser;

  Future<void> _init() async {
    emit(HomeLoading());
    try {
      final user = await _getValidUser();
      _currentUser = user;
      final todosResult = await _todoService.getTodos(user.uid.toString());
      final groupsResult = await _groupService.getGroupsByUser(
        user.uid.toString(),
      );

      final todos = todosResult.isSuccess()
          ? todosResult.getOrNull() ?? <TodoModel>[]
          : <TodoModel>[];
      final groups = groupsResult.isSuccess()
          ? groupsResult.getOrNull() ?? <GroupModel>[]
          : <GroupModel>[];

      emit(HomeLoaded(user: user, todos: todos, groups: groups));
    } catch (e) {
      emit(HomeError(AppException.unknown()));
    }
  }

  Future<void> logout() async {
    emit(HomeLoading());
    try {
      final user = await _getValidUser();
      await user.deleteFromSecureStorage();
      await _authService.signOut();
      emit(HomeInitial());
    } catch (e) {
      emit(HomeError(AppException.unknown()));
    }
  }

  Future<void> getTodos() async {
    emit(HomeLoading());
    try {
      final user = await _getValidUser();
      final result = await _todoService.getTodos(user.uid.toString());
      result.fold((todos) {
        final currentState = state is HomeLoaded ? state as HomeLoaded : null;
        emit(
          HomeLoaded(
            user: currentState?.user ?? user,
            todos: todos,
            groups: currentState?.groups,
          ),
        );
      }, (error) => emit(HomeError(AppException.notFound())));
    } catch (e) {
      emit(HomeError(AppException.unknown()));
    }
  }

  Future<void> addTodo(TodoModel todo) async {
    emit(HomeLoading());
    final result = await _todoService.addTodo(todo);
    result.fold(
      (todo) async => await getTodos(),
      (error) => emit(HomeError(AppException.notFound())),
    );
  }

  Future<void> updateTodo(TodoModel todo, {bool silent = false}) async {
    if (!silent) emit(HomeLoading());
    final result = await _todoService.updateTodo(todo);
    result.fold(
      (todo) async => await getTodos(),
      (error) => emit(HomeError(AppException.notFound())),
    );
  }

  Future<void> deleteTodo(String todoId) async {
    emit(HomeLoading());
    final result = await _todoService.deleteTodo(todoId);
    result.fold(
      (success) async => await getTodos(),
      (error) => emit(HomeError(AppException.notFound())),
    );
  }

  Future<void> getUserGroups() async {
    emit(HomeLoading());
    try {
      final user = await _getValidUser();
      final result = await _groupService.getGroupsByUser(user.uid.toString());
      result.fold((groups) {
        final currentState = state is HomeLoaded ? state as HomeLoaded : null;
        emit(
          HomeLoaded(
            user: currentState?.user ?? user,
            todos: currentState?.todos,
            groups: groups,
          ),
        );
      }, (error) => emit(HomeError(AppException.notFound())));
    } catch (e) {
      emit(HomeError(AppException.unknown()));
    }
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
          photoUrl: firebaseUser.photoURL,
        );
        await user.saveToSecureStorage();
      } else {
        throw AppException.userNotFound();
      }
    }
    return user;
  }
}
