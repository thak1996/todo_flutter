import 'package:todo_flutter/app/core/exceptions/app.exception.dart';
import 'package:todo_flutter/app/core/models/todo.model.dart';
import 'package:todo_flutter/app/core/models/user.model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  HomeLoaded(this.user);

  final UserModel user;
}

class HomeTodosLoaded extends HomeState {
  HomeTodosLoaded(this.todos);

  final List<TodoModel> todos;
}

class HomeTodoCreated extends HomeState {
  HomeTodoCreated(this.todo);

  final TodoModel todo;
}

class HomeError extends HomeState {
  HomeError(this.message);

  final AppException message;
}
