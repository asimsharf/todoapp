import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/BL/blocs/todo/todo_blocs.dart';
import 'package:todoapp/BL/blocs/todo/todo_filter_bloc.dart';
import 'package:todoapp/utils/constants.dart';
import 'package:todoapp/utils/the_colors.dart';

BlocConsumer<TodosFilterBloc, TodosFilterState> theTodos(String title) {
  return BlocConsumer<TodosFilterBloc, TodosFilterState>(
    listener: (context, state) {
      if (state is TodosFilterLoadedState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.todosFilter.toString().split('.').last),
          ),
        );
      }
    },
    builder: (context, state) {
      final todosBloc = context.read<TodosBloc>();
      if (state is TodosFilterLoadingState) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is TodosFilterLoadedState) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: TheColors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.filteredTodos.length,
                  itemBuilder: (context, i) {
                    Constance.theLogger.d(state.filteredTodos[i].id);
                    return Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: TheColors.black,
                      ),
                      child: ListTile(
                        title: Text(
                          state.filteredTodos[i].id.toString(),
                          style: const TextStyle(
                            color: TheColors.white,
                          ),
                        ),
                        subtitle: Text(
                          state.filteredTodos[i].todo,
                          style: const TextStyle(
                            color: TheColors.white,
                          ),
                        ),
                        leading: InkWell(
                          onTap: () {
                            todosBloc.add(
                              UpdateTodos(
                                todo: state.filteredTodos[i].copyWith(
                                  isCompleted:
                                      !state.filteredTodos[i].isCompleted!,
                                ),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.add_task,
                            color: TheColors.white,
                          ),
                        ),
                        trailing: InkWell(
                          onTap: () {
                            todosBloc.add(
                              DeleteTodos(todo: state.filteredTodos[i]),
                            );
                          },
                          child: const Icon(
                            CupertinoIcons.trash,
                            color: TheColors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }
      return const Center(child: Text("عفوا هنالك خطأ ما!"));
    },
  );
}
