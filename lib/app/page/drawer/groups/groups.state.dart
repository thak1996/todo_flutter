import 'package:todo_flutter/app/core/exceptions/app.exception.dart';
import 'package:todo_flutter/app/core/models/export.models.dart';

abstract class GroupsState {}

class GroupsLoading extends GroupsState {}

class GroupsLoaded extends GroupsState {
  GroupsLoaded({this.groups});

  final List<GroupModel>? groups;
}

class GroupsError extends GroupsState {
  GroupsError(this.message);

  final AppException message;
}
