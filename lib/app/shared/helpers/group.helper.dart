import 'package:todo_flutter/app/core/models/group.model.dart';
import 'package:todo_flutter/app/core/service/group.service.dart';

class GroupHelper {
  static Future<List<GroupModel>> ensureDefaultGroup({
    required GroupService groupService,
    required String userId,
  }) async {
    final groupsResult = await groupService.getGroupsByUser(userId);
    final groups = groupsResult.isSuccess()
        ? groupsResult.getOrNull() ?? <GroupModel>[]
        : <GroupModel>[];

    if (!groups.hasDefaultGroup) {
      await groupService.createDefaultGroup(userId: userId);
      final updatedGroupsResult = await groupService.getGroupsByUser(userId);
      return updatedGroupsResult.isSuccess()
          ? updatedGroupsResult.getOrNull() ?? <GroupModel>[]
          : <GroupModel>[];
    }
    return groups;
  }
}

extension GroupListExtension on List<GroupModel> {
  bool get hasDefaultGroup => any((g) => g.isDefault == true);
}
