import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:result_dart/result_dart.dart';
import 'package:todo_flutter/app/core/interfaces/group.interface.dart';
import '../models/group.model.dart';

class GroupService implements IGroupService {
  final _db = FirebaseFirestore.instance;

  @override
  AsyncResult<List<GroupModel>> getGroupsByUser(String userId) async {
    try {
      final query = await _db
          .collection('groups')
          .where('userId', isEqualTo: userId)
          .get();

      final groups = query.docs
          .map((doc) => GroupModel.fromMap(doc.data(), doc.id))
          .toList();

      return Success(groups);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }
}
