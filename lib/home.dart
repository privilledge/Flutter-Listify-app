// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'todoTasks.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<String> todotasks = [];
  List<bool> completed = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      todotasks = prefs.getStringList('todotasks') ?? [];
      completed =
          prefs.getStringList('completed')?.map((e) => e == 'true').toList() ??
              [];
    });
  }

  _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('todotasks', todotasks);
    prefs.setStringList(
        'completed', completed.map((e) => e.toString()).toList());
  }

  void _markTaskAsCompleted(int index) {
    setState(() {
      // Update the completed list
      completed[index] = true;
      // Remove the task from the todo list
      todotasks.removeAt(index);
      completed.removeAt(index);
    });
    _saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text(
          'Listiffy',
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
              title: Text("To-do tasks page"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  '/todotasks',
                  arguments: {
                    'todotasks': todotasks,
                    'onTaskComplete': _markTaskAsCompleted,
                  },
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: todotasks.isEmpty
          ? const Center(
              child: Text(
                "No tasks",
                style: TextStyle(fontSize: 23.0),
              ),
            )
          : ListView.builder(
              itemCount: todotasks.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: Checkbox(
                        value: completed.isNotEmpty && completed[index],
                        onChanged: (bool? value) {
                          setState(() {
                            completed[index] = value!;
                            if (completed[index]) {
                              _markTaskAsCompleted(index);
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
                          _saveTasks();
                        },
                      ),
                    ),
                    if (index != todotasks.length - 1) const Divider(),
                  ],
                );
              },
            ),
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
                _saveTasks();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
