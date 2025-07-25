import 'package:result_dart/result_dart.dart';
import 'package:todo_flutter/app/core/models/todo.model.dart';

abstract class ITodoService {
  AsyncResult<TodoModel> addTodo(TodoModel todo);
  AsyncResult<List<TodoModel>> getTodos(String userId);
  AsyncResult<List<TodoModel>> getTodosByGroup(String groupId);
  AsyncResult<TodoModel> updateTodo(TodoModel todo);
  AsyncResult<Unit> deleteTodo(String id);
}
