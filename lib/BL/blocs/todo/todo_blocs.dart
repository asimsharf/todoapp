import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/DL/entities/todo.dart';

import '../../../DL/services/todo_services.dart';

part '../../events/todo/todo_events.dart';
part '../../states/todo/todo_states.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc({required TodoServices todoServices}) : super(TodosLoadingState()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodos>(_onAddTodos);
    on<UpdateTodos>(_onUpdateTodos);
    on<DeleteTodos>(_onDeleteTodos);
  }

  void _onLoadTodos(LoadTodos event, Emitter<TodosState> emit) async {
    final todos = await TodoServices().getAllTodos();
    emit(TodosLoadedState(todos: todos));
  }

  void _onAddTodos(AddTodos event, Emitter<TodosState> emit) async {
    final state = this.state;

    if (state is TodosLoadedState) {
      final todo = Todo(
        id: state.todos.last.id + 1,
        userId: event.todo.userId,
        todo: event.todo.todo,
        isCompleted: event.todo.isCompleted,
      );

      await TodoServices().addTodo(body: todo.toJson());

      emit(TodosLoadedState(todos: List.from(state.todos)..add(event.todo)));
    }
  }

  void _onUpdateTodos(UpdateTodos event, Emitter<TodosState> emit) {
    final state = this.state;
    if (state is TodosLoadedState) {
      List<Todo> todos = (state.todos
              .map((todo) => todo.id == event.todo.id ? event.todo : todo))
          .toList();
      emit(TodosLoadedState(todos: todos));
    }
  }

  void _onDeleteTodos(DeleteTodos event, Emitter<TodosState> emit) {
    final state = this.state;
    if (state is TodosLoadedState) {
      List<Todo> todos =
          state.todos.where((todo) => todo.id != event.todo.id).toList();
      emit(TodosLoadedState(todos: todos));
    }
  }
}
