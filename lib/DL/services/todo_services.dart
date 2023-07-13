import 'package:todoapp/DL/repositories/todo_repository.dart';

import '../entities/todo.dart';

class TodoServices {
  final TodoRepository _todoRepository = TodoRepository();

  Future<List<Todo>> getAllTodos() async {
    return await _todoRepository.getAllTodos();
  }

  Future<Todo> getTodoById({required int id}) async {
    return await _todoRepository.getTodoById(id: id);
  }

  Future<Todo> addTodo({required Map body}) async {
    return await _todoRepository.addTodo(body: body);
  }

  Future<Todo> updateTodo({required int id, required Map body}) async {
    return await _todoRepository.updateTodo(id: id, body: body);
  }

  Future<Todo> deleteTodo({required int id}) async {
    return await _todoRepository.deleteTodo(id: id);
  }
}
