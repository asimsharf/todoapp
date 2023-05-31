part of 'package:todoapp/BL/blocs/todo/todo_filter_bloc.dart';

abstract class TodosFilterEvent extends Equatable {
  const TodosFilterEvent();

  @override
  List<Object> get props => [];
}

class UpdateFilter extends TodosFilterEvent {
  const UpdateFilter();

  @override
  List<Object> get props => [];
}

class UpdateFilterTodos extends TodosFilterEvent {
  final TodosFilter todosFilter;

  const UpdateFilterTodos({this.todosFilter = TodosFilter.all});

  @override
  List<Object> get props => [todosFilter];
}
