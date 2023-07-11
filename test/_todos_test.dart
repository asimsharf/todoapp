import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/DL/entities/todo.dart';
import 'package:todoapp/DL/services/todo_services.dart';

void main() {
  TodoServices todosService = TodoServices();

  test('Get all todos', () async {
    final List<Todo> todos = await todosService.getAllTodos();

    expect(todos, isA<List<Todo>>());
  });
}
