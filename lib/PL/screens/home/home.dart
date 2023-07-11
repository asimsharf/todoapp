import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/BL/blocs/todo/todo_blocs.dart';
import 'package:todoapp/BL/blocs/todo/todo_filter_bloc.dart';
import 'package:todoapp/utils/enums.dart';
import 'package:todoapp/utils/the_colors.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("المهام اليومية"),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/create_todos');
            },
            icon: const Icon(CupertinoIcons.add_circled),
          ),
          bottom: TabBar(
            onTap: (tapIndex) {
              switch (tapIndex) {
                case 0:
                  BlocProvider.of<TodosFilterBloc>(context).add(
                    const UpdateFilterTodos(
                      todosFilter: TodosFilter.pending,
                    ),
                  );
                  break;
                case 1:
                  BlocProvider.of<TodosFilterBloc>(context).add(
                    const UpdateFilterTodos(
                      todosFilter: TodosFilter.completed,
                    ),
                  );
                  break;
              }
            },
            tabs: const [
              Tab(
                icon: Icon(Icons.pending),
              ),
              Tab(
                icon: Icon(Icons.add_task),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _todos("المهام المنظرة"),
            _todos("المهام المكتملة"),
          ],
        ),
      ),
    );
  }

  BlocConsumer<TodosFilterBloc, TodosFilterState> _todos(String title) {
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
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.filteredTodos.length,
                  itemBuilder: (context, i) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: TheColors.black,
                      ),
                      child: ListTile(
                        title: Text(
                          state.filteredTodos[i].task,
                          style: const TextStyle(
                            color: TheColors.white,
                          ),
                        ),
                        subtitle: Text(
                          state.filteredTodos[i].description,
                          style: const TextStyle(
                            color: TheColors.deepWhite,
                          ),
                        ),
                        leading: InkWell(
                          onTap: () {
                            context.read<TodosBloc>().add(
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
                            context.read<TodosBloc>().add(
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
              ],
            ),
          );
        }
        return const Center(child: Text("عفوا هنالك خطأ ما!"));
      },
    );
  }
}
