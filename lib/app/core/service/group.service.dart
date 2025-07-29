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
          .where('isDefault', isEqualTo: true)
          .get();

      final groups = query.docs
          .map((doc) => GroupModel.fromMap(doc.data(), doc.id))
          .toList();

      return Success(groups);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  @override
  AsyncResult<GroupModel> createGroup({
    required String userId,
    required String name,
    String? description,
    bool isDefault = false,
  }) async {
    try {
      final docRef = await _db.collection('groups').add({
        'userId': userId,
        'name': name,
        'description': description ?? '',
        'isDefault': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
      final doc = await docRef.get();
      final group = GroupModel.fromMap(doc.data()!, doc.id);
      return Success(group);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  AsyncResult<GroupModel> createDefaultGroup( {
    required String userId,
    String name = 'Pessoal',
    String? description,
  }) async {
    try {
      final docRef = await _db.collection('groups').add({
        'userId': userId,
        'name': name,
        'description': description ?? '',
        'isDefault': true,
        'createdAt': FieldValue.serverTimestamp(),
      });
      final doc = await docRef.get();
      final group = GroupModel.fromMap(doc.data()!, doc.id);
      return Success(group);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }
}
