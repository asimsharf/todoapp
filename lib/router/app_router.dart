import 'package:flutter/material.dart';
import 'package:todoapp/PL/screens/home/create_todos.dart';
import 'package:todoapp/PL/screens/home/home.dart';
import 'package:todoapp/PL/screens/splash.dart';
import 'package:todoapp/utils/the_colors.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const Splash());
      case '/home':
        return MaterialPageRoute(builder: (_) => const Home());
      case '/create_todos':
        return MaterialPageRoute(builder: (_) => const CreateTodos());
      default:
        return MaterialPageRoute(builder: (context) => const NotFound());
    }
  }
}

class NotFound extends StatelessWidget {
  const NotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "المعذرة الصفحة غير متوفر!",
              style: TextStyle(
                color: TheColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: OutlinedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(
                    color: TheColors.lightRed,
                    width: 2.0,
                  ),
                ),
              ),
              child: const Text(
                "رجوع",
                style: TextStyle(
                  color: TheColors.lightRed,
                  fontFamily: 'montserrat_regular',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
