import 'package:todo_flutter/app/core/exceptions/app.exception.dart';
import 'package:todo_flutter/app/core/models/group.model.dart';
import 'package:todo_flutter/app/core/models/todo.model.dart';
import 'package:todo_flutter/app/core/models/user.model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeUserLoaded extends HomeState {
  HomeUserLoaded(this.user);

  final UserModel user;
}

class HomeTodoLoaded extends HomeState {
  HomeTodoLoaded(this.todos);

  final List<TodoModel> todos;
}

class HomeTodoCreated extends HomeState {
  HomeTodoCreated(this.todo);

  final TodoModel todo;
}

class HomeGroupsLoaded extends HomeState {
  HomeGroupsLoaded(this.groups);

  final List<GroupModel> groups;
}

class HomeError extends HomeState {
  HomeError(this.message);

  final AppException message;
}
