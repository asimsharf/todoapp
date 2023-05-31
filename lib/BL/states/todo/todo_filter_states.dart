part of 'package:todoapp/BL/blocs/todo/todo_filter_bloc.dart';

abstract class TodosFilterState extends Equatable {
  const TodosFilterState();

  @override
  List<Object> get props => [];
}

class TodosFilterLoading extends TodosFilterState {
  const TodosFilterLoading();
}

class TodosFilterLoaded extends TodosFilterState {
  final List<Todo> filteredTodos;
  final TodosFilter todosFilter;

  const TodosFilterLoaded({
    required this.filteredTodos,
    this.todosFilter = TodosFilter.all,
  });

  @override
  List<Object> get props => [filteredTodos, todosFilter];
}
