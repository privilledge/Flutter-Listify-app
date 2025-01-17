import 'package:flutter/material.dart';

class TodoTasks extends StatelessWidget {
  final List<String> todotasks;
  final Function(int) onTaskComplete; // Define the callback parameter

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
                  Text("No tasks available", style: TextStyle(fontSize: 20.0)),
            )
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
                        icon: Icon(Icons.delete, size: 19.0),
                        onPressed: () {
                          onTaskComplete(index); // Call the callback
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
