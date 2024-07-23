import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompletedTasks extends StatefulWidget {
  final List<String> completedTasks;

  CompletedTasks({super.key, required this.completedTasks});

  @override
  _CompletedTasksState createState() => _CompletedTasksState();
}

class _CompletedTasksState extends State<CompletedTasks> {
  List<String> completedTasks = [];

  @override
  void initState() {
    super.initState();
    completedTasks = widget.completedTasks;
  }

  _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('completedTasks', completedTasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Completed Tasks"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: completedTasks.isEmpty
          ? Center(
              child:
                  Text("No completed tasks", style: TextStyle(fontSize: 20.0)),
            )
          : ListView.builder(
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        completedTasks[index],
                        style: const TextStyle(
                          fontSize: 18.0,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, size: 19.0),
                        onPressed: () {
                          setState(() {
                            completedTasks.removeAt(index);
                            _saveTasks();
                          });
                        },
                      ),
                    ),
                    if (index != completedTasks.length - 1) const Divider()
                  ],
                );
              },
            ),
    );
  }
}
