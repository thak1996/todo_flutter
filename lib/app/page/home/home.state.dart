import 'package:todo_flutter/app/core/exceptions/app.exception.dart';
import 'package:todo_flutter/app/core/models/export.models.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  HomeLoaded({this.user, this.todos, this.groups});

  final List<GroupModel>? groups;
  final List<TodoModel>? todos;
  final UserModel? user;
}

class HomeError extends HomeState {
  HomeError(this.error);

  final AppException error;
}
