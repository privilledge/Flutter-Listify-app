import 'package:flutter/material.dart';
import 'home.dart';
import 'todoTasks.dart';
import 'settings.dart';

void main() => runApp(const TodoApp());

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo app',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: TodoListScreen(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/todotasks':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => TodoTasks(
                todotasks: args['todotasks'],
                onTaskComplete: args['onTaskComplete'],
              ),
            );
          case '/settings':
            final args = settings.arguments as List<String>;
            return MaterialPageRoute(
              builder: (context) => SettingsPage(),
            );
          default:
            return null;
        }
      },
    );
  }
}
