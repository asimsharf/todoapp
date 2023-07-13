import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int id;
  final int userId;
  final String todo;
  final bool? isCompleted;

  const Todo({
    required this.id,
    required this.userId,
    required this.todo,
    this.isCompleted = false,
  });

  Todo copyWith({
    int? id,
    int? userId,
    String? todo,
    String? description,
    bool? isCompleted,
  }) =>
      Todo(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        todo: todo ?? this.todo,
        isCompleted: isCompleted ?? this.isCompleted,
      );

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      userId: json['userId'],
      todo: json['todo'],
      isCompleted: json['completed'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'todo': todo,
        'completed': isCompleted,
      };

  @override
  List<Object?> get props => [id, userId, isCompleted];
}
