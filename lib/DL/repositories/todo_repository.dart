import 'dart:convert';

import 'package:http/http.dart' as http;

import '../entities/todo.dart';

class TodoRepository {
  Future<List<Todo>> getAllTodos() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/todos'));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      List todos = json['todos'];

      return todos.map((todo) => Todo.fromJson(todo)).toList();
    }

    return [];
  }

  Future<Todo> getTodoById(int id) async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/todos/$id'));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return Todo.fromJson(json);
    }

    return const Todo(
      id: 0,
      userId: 0,
      todo: '',
      isCompleted: false,
      isCancelled: false,
    );
  }

  Future<Todo> addTodo({
    required int userId,
    required String todo,
    bool isCompleted = false,
  }) async {
    final response = await http.post(
      Uri.parse('https://dummyjson.com/todos/add'),
      body: json.encode({
        'userId': userId,
        'todo': todo,
        'completed': isCompleted,
      }),
    );

    print(response.body);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return Todo.fromJson(json);
    }

    return const Todo(
      id: 0,
      userId: 0,
      todo: '',
      isCompleted: false,
      isCancelled: false,
    );
  }

  Future<Todo> updateTodo({
    required int id,
    required int userId,
    required String todo,
    bool isCompleted = false,
  }) async {
    final response = await http.put(
      Uri.parse('https://dummyjson.com/todos/$id'),
      body: {
        'id': id,
        'userId': userId,
        'todo': todo,
        'completed': isCompleted,
      },
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return Todo.fromJson(json);
    }

    return const Todo(
      id: 0,
      userId: 0,
      todo: '',
      isCompleted: false,
      isCancelled: false,
    );
  }

  Future<Todo> deleteTodoById(int id) async {
    final response =
        await http.delete(Uri.parse('https://dummyjson.com/todos/$id'));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return Todo.fromJson(json);
    }

    return const Todo(
      id: 0,
      userId: 0,
      todo: '',
      isCompleted: false,
      isCancelled: false,
    );
  }

  Future<Todo> completeTodoById(int id) async {
    final response =
        await http.put(Uri.parse('https://dummyjson.com/todos/$id'), body: {
      'isCompleted': true,
    });

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return Todo.fromJson(json);
    }

    return const Todo(
      id: 0,
      userId: 0,
      todo: '',
      isCompleted: false,
      isCancelled: false,
    );
  }

  Future<Todo> cancelTodoById(int id) async {
    final response =
        await http.put(Uri.parse('https://dummyjson.com/todos/$id'), body: {
      'isCancelled': true,
    });

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return Todo.fromJson(json);
    }

    return const Todo(
      id: 0,
      userId: 0,
      todo: '',
      isCompleted: false,
      isCancelled: false,
    );
  }

  Future<Todo> uncompleteTodoById(int id) async {
    final response =
        await http.put(Uri.parse('https://dummyjson.com/todos/$id'), body: {
      'isCompleted': false,
    });

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return Todo.fromJson(json);
    }

    return const Todo(
      id: 0,
      userId: 0,
      todo: '',
      isCompleted: false,
      isCancelled: false,
    );
  }
}
