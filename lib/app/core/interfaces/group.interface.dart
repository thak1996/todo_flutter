import 'package:result_dart/result_dart.dart';
import 'package:todo_flutter/app/core/models/group.model.dart';

abstract class IGroupService {
  AsyncResult<List<GroupModel>> getGroupsByUser(String userId);
}
