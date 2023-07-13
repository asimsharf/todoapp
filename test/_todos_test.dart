import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/DL/entities/todo.dart';
import 'package:todoapp/DL/services/todo_services.dart';

void main() {
  TodoServices todosService = TodoServices();

  test('Get all todos', () async {
    final List<Todo> todos = await todosService.getAllTodos();

    expect(todos, isA<List<Todo>>());
  });

  test('Post a todo', () async {
    final Todo todo = await todosService.addTodo(
      body: {
        'userId': 5,
        'todo': 'Test todo',
        'isCompleted': false,
      },
    );

    expect(todo, isA<Todo>());
  });

  test('Update a todo', () async {
    final Todo todo = await todosService.updateTodo(
      id: 1,
      body: {
        'userId': 5,
        'todo': 'Test todo',
        'isCompleted': false,
      },
    );

    expect(todo, isA<Todo>());
  });

  test('Delete a todo', () async {
    final Todo todo = await todosService.deleteTodo(id: 1);

    expect(todo, isA<Todo>());
  });
}
