import 'package:todo_flutter/app/core/exceptions/app.exception.dart';
import 'package:todo_flutter/app/core/models/export.models.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final UserModel? user;
  final List<TodoModel>? todos;
  final List<GroupModel>? groups;
  HomeLoaded({this.user, this.todos, this.groups});
}

class HomeError extends HomeState {
  final AppException error;
  HomeError(this.error);
}
