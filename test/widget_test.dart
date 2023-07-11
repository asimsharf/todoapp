import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/DL/services/todo_services.dart';
import 'package:todoapp/main.dart';
import 'package:todoapp/router/app_router.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      App(
        appRouter: AppRouter(),
        connectivity: Connectivity(),
        todoServices: TodoServices(),
      ),
    );

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
