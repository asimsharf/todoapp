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

  Future<Todo> getTodoById({required int id}) async {
    final res = await http.get(Uri.parse('https://dummyjson.com/todos/$id'));

    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      return Todo.fromJson(json);
    }

    return const Todo(
      id: 0,
      userId: 0,
      todo: '',
      isCompleted: false,
    );
  }

  Future<Todo> addTodo({required Map body}) async {
    final res = await http.post(
      Uri.parse('https://dummyjson.com/todos/add'),
      body: json.encode(body),
    );

    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      return Todo.fromJson(json);
    }

    return const Todo(
      id: 0,
      userId: 0,
      todo: '',
      isCompleted: false,
    );
  }

  Future<Todo> updateTodo({required int id, required Map body}) async {
    final res = await http.put(
      Uri.parse('https://dummyjson.com/todos/$id}'),
      body: body,
    );

    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      return Todo.fromJson(json);
    }

    return const Todo(
      id: 0,
      userId: 0,
      todo: '',
      isCompleted: false,
    );
  }

  Future<Todo> deleteTodo({required int id}) async {
    final res = await http.delete(
      Uri.parse('https://dummyjson.com/todos/$id'),
    );

    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      return Todo.fromJson(json);
    }

    return const Todo(
      id: 0,
      userId: 0,
      todo: '',
      isCompleted: false,
    );
  }
}
