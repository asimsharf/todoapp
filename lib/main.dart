import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todoapp/BL/blocs/todo/todo_blocs.dart';
import 'package:todoapp/BL/blocs/todo/todo_filter_bloc.dart';
import 'package:todoapp/DL/entities/todo.dart';
import 'package:todoapp/router/app_router.dart';
import 'package:todoapp/utils/the_colors.dart';

Future main() async {
  await dotenv.load(
    fileName: "assets/.env",
    mergeWith: {
      'TEST_VAR': '5',
    },
  );

  runApp(
    App(
      appRouter: AppRouter(),
      connectivity: Connectivity(),
    ),
  );
}

class App extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;

  const App({
    super.key,
    required this.appRouter,
    required this.connectivity,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodosBloc()
            ..add(
              LoadTodos(
                todos: [
                  Todo(
                    id: '1',
                    task: 'عنوان المهمة الاول',
                    description: 'عبارة عن وصف للمهمة الاول يكون هنا',
                  ),
                  Todo(
                    id: '2',
                    task: 'عنوان المهمة الثاني',
                    description: 'عبارة عن صوف للمهمة الثاني يكون هنا',
                  ),
                ],
              ),
            ),
        ),
        BlocProvider(
          create: (context) => TodosFilterBloc(
            todosBloc: BlocProvider.of<TodosBloc>(context),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: dotenv.env['DEBUG'] == 'true',
        title: 'ToDos',
        theme: ThemeData(
          primaryColor: TheColors.primary,
          scaffoldBackgroundColor: TheColors.primary,
          fontFamily: 'montserrat_regular',
          appBarTheme: const AppBarTheme(
            backgroundColor: TheColors.primary,
            elevation: 0,
          ),
        ),
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("ar", "AE"),
        ],
        locale: const Locale("ar", "AE"),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
