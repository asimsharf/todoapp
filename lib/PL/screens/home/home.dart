import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/BL/blocs/todo/todo_filter_bloc.dart';
import 'package:todoapp/utils/enums.dart';

import '../../widgets/the_todos.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todosFilter = BlocProvider.of<TodosFilterBloc>(context);
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
                  todosFilter.add(
                    const UpdateFilterTodos(
                      todosFilter: TodosFilter.pending,
                    ),
                  );
                  break;
                case 1:
                  todosFilter.add(
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
            theTodos("المهام المنظرة"),
            theTodos("المهام المكتملة"),
          ],
        ),
      ),
    );
  }
}
