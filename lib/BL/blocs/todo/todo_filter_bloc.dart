import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/BL/blocs/todo/todo_blocs.dart';
import 'package:todoapp/DL/entities/todo.dart';
import 'package:todoapp/utils/enums.dart';

part 'package:todoapp/BL/events/todo/todo_filter_events.dart';
part 'package:todoapp/BL/states/todo/todo_filter_states.dart';

class TodosFilterBloc extends Bloc<TodosFilterEvent, TodosFilterState> {
  final TodosBloc _todosBloc;
  late StreamSubscription _streamSubscription;

  TodosFilterBloc({required TodosBloc todosBloc})
      : _todosBloc = todosBloc,
        super(const TodosFilterLoadingState()) {
    on<UpdateFilter>(_onUpdateFilter);
    on<UpdateFilterTodos>(_onUpdateTodos);

    _streamSubscription = _todosBloc.stream.listen((state) {
      add(const UpdateFilter());
    });
  }

  void _onUpdateFilter(UpdateFilter event, Emitter<TodosFilterState> emit) {
    if (state is TodosFilterLoadingState) {
      add(const UpdateFilterTodos(todosFilter: TodosFilter.pending));
    }

    if (state is TodosFilterLoadedState) {
      final state = this.state as TodosFilterLoadedState;
      add(UpdateFilterTodos(todosFilter: state.todosFilter));
    }
  }

  void _onUpdateTodos(UpdateFilterTodos event, Emitter<TodosFilterState> emit) {
    final state = _todosBloc.state;

    if (state is TodosLoadedState) {
      List<Todo> todos = state.todos.where((todo) {
        switch (event.todosFilter) {
          case TodosFilter.all:
            return true;
          case TodosFilter.completed:
            return todo.isCompleted!;
          case TodosFilter.pending:
            return !(todo.isCompleted!);
        }
      }).toList();

      emit(TodosFilterLoadedState(
          filteredTodos: todos, todosFilter: event.todosFilter));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
