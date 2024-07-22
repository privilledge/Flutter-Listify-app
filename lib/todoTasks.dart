// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'home.dart';

class TodoTasks extends StatelessWidget {
  final List<String> todotasks;
  TodoTasks({super.key, required this.todotasks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Todo tasks"),
          backgroundColor: Colors.pinkAccent,
        ),
        body: ListView.builder(itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                title: Text(
                  todotasks[index],
                  style: TextStyle(fontSize: 18.0),
                ),
                trailing: Icon(
                  Icons.delete,
                  size: 19.0,
                ),
              )
            ],
          );
        }));
  }
}
