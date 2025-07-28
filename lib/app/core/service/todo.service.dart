import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:result_dart/result_dart.dart';
import 'package:todo_flutter/app/shared/utils/log_printer.dart';
import '../models/todo.model.dart';
import '../interfaces/todo.interface.dart';
import '../exceptions/general.exception.dart';

class TodoService implements ITodoService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final Logger _logger = Logger(printer: LoggerPrinter('TodoService'));

  @override
  AsyncResult<TodoModel> addTodo(TodoModel todo) async {
    try {
      final docRef = await _db.collection('todos').add(todo.toMap());
      final doc = await docRef.get();
      final newTodo = TodoModel.fromMap(doc.data()!, doc.id);
      return Success(newTodo);
    } catch (e) {
      return Failure(GeneralException.unexpected(e.toString()));
    }
  }

  @override
  AsyncResult<List<TodoModel>> getTodos(String userId) async {
    try {
      final snapshot = await _db
          .collection('todos')
          .where('userId', isEqualTo: userId)
          .where('deletedAt', isNull: true)
          .get();
      _logger.i('Fetched ${snapshot.docs.length} todos for user $userId');
      final todos = snapshot.docs
          .map((doc) => TodoModel.fromMap(doc.data(), doc.id))
          .toList();
      return Success(todos);
    } catch (e) {
      _logger.e('Error fetching todos for user $userId: ${e.toString()}');
      return Failure(GeneralException.unexpected(e.toString()));
    }
  }

  @override
  AsyncResult<List<TodoModel>> getTodosByGroup(String groupId) async {
    try {
      final snapshot = await _db
          .collection('todos')
          .where('groupId', isEqualTo: groupId)
          .where('deletedAt', isNull: true)
          .get();
      _logger.i('Fetched ${snapshot.docs.length} todos for group $groupId');
      final todos = snapshot.docs
          .map((doc) => TodoModel.fromMap(doc.data(), doc.id))
          .toList();
      return Success(todos);
    } catch (e) {
      _logger.e('Error fetching todos for group $groupId: ${e.toString()}');
      return Failure(GeneralException.unexpected(e.toString()));
    }
  }

  @override
  AsyncResult<TodoModel> updateTodo(TodoModel todo) async {
    try {
      await _db.collection('todos').doc(todo.id).update(todo.toMap());
      final doc = await _db.collection('todos').doc(todo.id).get();
      final updatedTodo = TodoModel.fromMap(doc.data()!, doc.id);
      return Success(updatedTodo);
    } catch (e) {
      return Failure(GeneralException.unexpected(e.toString()));
    }
  }

  @override
  AsyncResult<Unit> deleteTodo(String id) async {
    try {
      await _db.collection('todos').doc(id).update({
        'deletedAt': DateTime.now().toIso8601String(),
      });
      return Success(unit);
    } catch (e) {
      return Failure(GeneralException.unexpected(e.toString()));
    }
  }
}
