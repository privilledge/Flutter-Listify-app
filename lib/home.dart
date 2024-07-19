// lib/home.dart
import 'package:flutter/material.dart';
import 'todoTasks.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<String> tasks = [];
  List<bool> completed = [];
  List<String> completedTasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'My Todo App',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.pinkAccent),
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
      body: tasks.isEmpty
          ? const Center(
              child: Text(
                "No tasks",
                style: TextStyle(fontSize: 23.0),
              ),
            )
          : ListView.builder(
              itemCount: tasks.length,
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
                              completedTasks.add(tasks[index]);
                            } else {
                              completedTasks.remove(tasks[index]);
                            }
                          });
                        },
                      ),
                      title: Text(
                        tasks[index],
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, size: 19.0),
                        onPressed: () {
                          setState(() {
                            tasks.removeAt(index);
                            completed.removeAt(index);
                          });
                        },
                      ),
                    ),
                    if (index != tasks.length - 1) const Divider()
                  ],
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        tooltip: 'Add task',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    TextEditingController taskController = TextEditingController();

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
                  tasks.add(taskController.text);
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
