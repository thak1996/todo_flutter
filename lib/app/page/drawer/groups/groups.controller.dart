import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/app/core/exceptions/exceptions.export.dart';
import 'package:todo_flutter/app/core/service/export.service.dart';
import 'package:todo_flutter/app/shared/helpers/export.helpers.dart';
import 'groups.state.dart';

class GroupsController extends Cubit<GroupsState> {
  GroupsController(this._authService, this._groupService)
    : super(GroupsLoading()) {
    init();
  }

  final GroupService _groupService;
  final AuthService _authService;

  Future<void> init() async {
    emit(GroupsLoading());
    try {
      final user = await UserHelper.getValidUser(_authService);
      final result = await _groupService.getGroupsByUser(user.uid.toString());
      result.fold(
        (groups) => emit(GroupsLoaded(groups: groups)),
        (error) => emit(GroupsError(AppException.unknown())),
      );
    } catch (e) {
      emit(GroupsError(AppException.unknown(e.toString())));
    }
  }

  Future<void> createGroup(String name) async {
    emit(GroupsLoading());
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
