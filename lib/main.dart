// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'home.dart';
import 'todoTasks.dart';

void main() => runApp(const TodoApp());

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo app',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const TodoListScreen(),
      onGenerateRoute: (settings) {
        if (settings.name == "/todotasks") {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => TodoTasks(
              todotasks: args['todotasks'],
              onTaskComplete: args['onTaskComplete'],
            ),
          );
        }
        return null;
      },
    );
  }
}
