// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TodoTasks extends StatelessWidget {
  const TodoTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo tasks"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: Text("Todo tasks"),
      ),
    );
  }
}
