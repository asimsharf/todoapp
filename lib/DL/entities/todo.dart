import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int id;
  final int userId;
  final String todo;
  final bool? isCompleted;
  final bool? isCancelled;

  const Todo({
    required this.id,
    required this.userId,
    required this.todo,
    this.isCompleted = false,
    this.isCancelled = false,
  });

  Todo copyWith({
    int? id,
    int? userId,
    String? todo,
    String? description,
    bool? isCompleted,
    bool? isCancelled,
  }) =>
      Todo(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        todo: todo ?? this.todo,
        isCompleted: isCompleted ?? this.isCompleted,
        isCancelled: isCancelled ?? this.isCancelled,
      );

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      userId: json['userId'],
      todo: json['todo'],
      isCompleted: json['completed'],
      isCancelled: json['completed'],
    );
  }

  @override
  List<Object?> get props => [id, userId, isCompleted, isCancelled];
}
