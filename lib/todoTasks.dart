// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TodoTasks extends StatelessWidget {
  final List<String> todotasks;
  final Function(int) onTaskComplete;

  TodoTasks({super.key, required this.todotasks, required this.onTaskComplete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo tasks"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: todotasks.isEmpty
          ? Center(
              child:
                  Text("No tasks available", style: TextStyle(fontSize: 20.0)))
          : ListView.builder(
              itemCount: todotasks.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        todotasks[index],
                        style: TextStyle(fontSize: 18.0),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.check, size: 19.0),
                        onPressed: () {
                          onTaskComplete(index);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    if (index != todotasks.length - 1) const Divider(),
                  ],
                );
              },
            ),
    );
  }
}
