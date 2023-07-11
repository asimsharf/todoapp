import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todoapp/BL/blocs/todo/todo_blocs.dart';
import 'package:todoapp/BL/blocs/todo/todo_filter_bloc.dart';
import 'package:todoapp/DL/services/todo_services.dart';
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
      todoServices: TodoServices(),
    ),
  );
}

class App extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;
  final TodoServices todoServices;

  const App({
    super.key,
    required this.appRouter,
    required this.connectivity,
    required this.todoServices,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return TodosBloc(todoServices: todoServices)
              ..add(const LoadTodos());
          },
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
