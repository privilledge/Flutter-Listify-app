// lib/home.dart
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'todoTasks.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<String> todotasks = [];
  List<bool> completed = [];
  List<String> completedTasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text(
          'Listify',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pinkAccent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // Drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.pinkAccent),
              child: Text(
                "Menu",
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.pending_actions),
              title: Text("To-do tasks"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/todoTasks');
              },
            ),
            ListTile(
              leading: Icon(Icons.done),
              title: Text("Completed tasks"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                onTap: () => Navigator.pop(context))
          ],
        ),
      ),
      body: todotasks.isEmpty && completedTasks.isEmpty
          ? const Center(
              child: Text(
                "No tasks",
                style: TextStyle(fontSize: 23.0),
              ),
            )
          : Expanded(
              child: ListView(
              children: [
                if (todotasks.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "To-do",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: todotasks.length,
                    itemBuilder: (context, index) {
                      if (index >= completed.length) {
                        completed.add(false);
                      }
                      return Column(
                        children: [
                          ListTile(
                            leading: Checkbox(
                              value: completed[index],
                              onChanged: (bool? value) {
                                setState(() {
                                  completed[index] = value!;
                                  if (completed[index]) {
                                    completedTasks.add(todotasks[index]);
                                    todotasks.removeAt(index);
                                  } else {
                                    completedTasks.remove(todotasks[index]);
                                  }
                                });
                              },
                            ),
                            title: Text(
                              todotasks[index],
                              style: const TextStyle(fontSize: 18.0),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, size: 19.0),
                              onPressed: () {
                                setState(() {
                                  todotasks.removeAt(index);
                                  completed.removeAt(index);
                                });
                              },
                            ),
                          ),
                          if (index != todotasks.length - 1) const Divider()
                        ],
                      );
                    },
                  ),
                ],
                if (completedTasks.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Completed",
                      style: TextStyle(
                          fontSize: 19.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: completedTasks.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            // leading: Checkbox(
                            //   value: completed[index],
                            //   onChanged: (bool? value) {
                            //     setState(() {
                            //       completed[index] = value!;
                            //       if (completed[index]) {
                            //         todotasks.add(completedTasks[index]);
                            //         completedTasks.removeAt(index);
                            //       } else {
                            //         todotasks.remove(completedTasks[index]);
                            //       }
                            //     });
                            //   },
                            // ),
                            title: Text(
                              completedTasks[index],
                              style: const TextStyle(
                                  fontSize: 18.0,
                                  decoration: TextDecoration.lineThrough),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, size: 19.0),
                              onPressed: () {
                                setState(() {
                                  completedTasks.removeAt(index);
                                });
                              },
                            ),
                          ),
                          if (index != completedTasks.length - 1)
                            const Divider()
                        ],
                      );
                    },
                  )
                ]
              ],
            )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        tooltip: 'Add task',
        backgroundColor: Color.fromARGB(255, 255, 111, 159),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    TextEditingController taskController = TextEditingController();
// Add task dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add text'),
          content: TextField(
            controller: taskController,
            decoration: const InputDecoration(hintText: 'Enter task'),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel')),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                setState(() {
                  todotasks.add(taskController.text);
                  completed.add(false);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
