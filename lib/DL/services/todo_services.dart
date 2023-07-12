import 'package:todoapp/DL/repositories/todo_repository.dart';

import '../entities/todo.dart';

class TodoServices {
  final TodoRepository _todoRepository = TodoRepository();

  Future<List<Todo>> getAllTodos() async {
    return await _todoRepository.getAllTodos();
  }

  Future<Todo> getTodoById(int id) async {
    return await _todoRepository.getTodoById(id);
  }

  Future<Todo> addTodo({
    required int userId,
    required String todo,
    bool isCompleted = false,
  }) async {
    return await _todoRepository.addTodo(
      userId: userId,
      todo: todo,
      isCompleted: isCompleted,
    );
  }

  Future<Todo> updateTodo({
    required int id,
    required int userId,
    required String todo,
    bool isCompleted = false,
  }) async {
    return await _todoRepository.updateTodo(
      id: id,
      userId: userId,
      todo: todo,
      isCompleted: isCompleted,
    );
  }
}
