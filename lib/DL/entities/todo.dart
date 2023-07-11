import 'package:equatable/equatable.dart';
import 'package:todoapp/utils/constants.dart';

class Todo extends Equatable {
  final String id;
  final String task;
  final String description;
  final bool? isCompleted;
  final bool? isCancelled;

  const Todo({
    required this.id,
    required this.task,
    required this.description,
    this.isCompleted = false,
    this.isCancelled = false,
  });

  Todo copyWith({
    String? id,
    String? task,
    String? description,
    bool? isCompleted,
    bool? isCancelled,
  }) =>
      Todo(
        id: id ?? this.id,
        task: task ?? this.task,
        description: description ?? this.description,
        isCompleted: isCompleted ?? this.isCompleted,
        isCancelled: isCancelled ?? this.isCancelled,
      );

  @override
  List<Object?> get props => [id, task, description, isCompleted, isCancelled];

  static List<Todo> todos = [
    Todo(
      id: Constance.theID,
      task: 'انشاء تطبيق مساند',
      description: "تفاصيل عن المهمة, وهي عبارة عن تطبيق مساند للمهام اليومية",
    ),
    Todo(
      id: Constance.theID,
      task: 'انشاء تطبيق مساند',
      description: "تفاصيل عن المهمة, وهي عبارة عن تطبيق مساند للمهام اليومية",
    ),
  ];
}
