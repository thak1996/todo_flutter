import 'package:todo_flutter/app/core/models/auth/user.model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  HomeLoaded(this.user);

  final UserModel user;
}

class HomeError extends HomeState {
  HomeError(this.message);

  final String message;
}
