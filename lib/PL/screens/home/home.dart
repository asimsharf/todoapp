import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/BL/blocs/todo/todo_blocs.dart';
import 'package:todoapp/utils/the_colors.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("المهام اليومية"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/create_todos');
          },
          icon: const Icon(CupertinoIcons.add_circled),
        ),
      ),
      body: BlocBuilder<TodosBloc, TodosState>(
        builder: (context, state) {
          if (state is TodosLoading) {
            return const CircularProgressIndicator();
          }
          if (state is TodosLoaded) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, i) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: TheColors.black,
                  ),
                  child: ListTile(
                    title: Text(
                      state.todos[i].task,
                      style: const TextStyle(
                        color: TheColors.white,
                      ),
                    ),
                    subtitle: Text(
                      state.todos[i].description,
                      style: const TextStyle(
                        color: TheColors.deepWhite,
                      ),
                    ),
                    leading: GestureDetector(
                      onTap: () {
                        context.read<TodosBloc>().add(
                              UpdateTodos(
                                todo: state.todos[i].copyWith(
                                  isCompleted: true,
                                ),
                              ),
                            );
                      },
                      child: Icon(
                        state.todos[i].isCompleted == true
                            ? CupertinoIcons.checkmark_alt_circle_fill
                            : CupertinoIcons.checkmark_alt_circle,
                        color: TheColors.white,
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        context
                            .read<TodosBloc>()
                            .add(DeleteTodos(todo: state.todos[i]));
                      },
                      child: const Icon(
                        CupertinoIcons.trash,
                        color: TheColors.white,
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: Text("عفوا هنالك خطأ ما!"));
        },
      ),
    );
  }
}
