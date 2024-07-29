import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings.dart'; // Import the SettingsPage

class TodoListScreen extends StatefulWidget {
  TodoListScreen({super.key});
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<String> todotasks = [];
  List<bool> completed = [];
  List<String> completedTasks = [];
  int _currentIndex = 0;

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
      completedTasks = prefs.getStringList('completedTasks') ?? [];
    });
  }

  _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('todotasks', todotasks);
    prefs.setStringList(
        'completed', completed.map((e) => e.toString()).toList());
    prefs.setStringList('completedTasks', completedTasks);
  }

  int _getPendingTaskCount() {
    return todotasks.length;
  }

  int _getCompletedTaskCount() {
    return completedTasks.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.all(19.0),
          child: const Text(
            'Listify',
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => {},
            icon: Icon(
              Icons.account_circle,
              size: 30.0,
            ),
          )
        ],
        backgroundColor: Colors.pinkAccent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _currentIndex == 0
          ? _buildTaskList() // Show todo list or completed tasks
          : SettingsPage(), // Show settings page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.pinkAccent,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(
              Icons.home,
              size: 35.0,
            ),
          ),
          BottomNavigationBarItem(
            label: "Settings",
            icon: Icon(
              Icons.settings,
              size: 35.0,
            ),
          )
        ],
        unselectedItemColor: Colors.grey,
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                _showAddTaskDialog(context);
              },
              tooltip: 'Add task',
              backgroundColor: const Color.fromARGB(255, 255, 111, 159),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : null,
    );
  }

  Widget _buildTaskList() {
    return todotasks.isEmpty && completedTasks.isEmpty
        ? Center(
            child: Text(
              "No tasks",
              style: TextStyle(fontSize: 23.0),
            ),
          )
        : ListView(
            children: [
              if (todotasks.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "To-do",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: todotasks.length,
                  itemBuilder: (context, index) {
                    if (index >= completed.length) {
                      completed.add(false);
                    }
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.zero,
                          child: ListTile(
                            leading: Checkbox(
                              value: completed[index],
                              onChanged: (bool? value) {
                                setState(() {
                                  completed[index] = value!;
                                  if (completed[index]) {
                                    completedTasks.add(todotasks[index]);
                                    todotasks.removeAt(index);
                                    completed.removeAt(index);
                                  }
                                  _saveTasks();
                                });
                              },
                            ),
                            title: Text(
                              todotasks[index],
                              style: const TextStyle(fontSize: 17.0),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, size: 20.0),
                              onPressed: () {
                                setState(() {
                                  todotasks.removeAt(index);
                                  completed.removeAt(index);
                                  _saveTasks();
                                });
                              },
                            ),
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
                    style:
                        TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
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
                          leading: Checkbox(
                            value: true,
                            onChanged: (bool? value) {
                              setState(() {
                                todotasks.add(completedTasks[index]);
                                completed.add(false);
                                completedTasks.removeAt(index);
                                _saveTasks();
                              });
                            },
                          ),
                          title: Text(
                            completedTasks[index],
                            style: const TextStyle(
                              fontSize: 17.0,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, size: 20.0),
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
              ],
            ],
          );
  }

  void _showAddTaskDialog(BuildContext context) {
    TextEditingController taskController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add task'),
          content: TextField(
            textCapitalization: TextCapitalization.sentences,
            controller: taskController,
            decoration: const InputDecoration(
              hintText: 'Enter task',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  todotasks.add(taskController.text);
                  completed.add(false);
                });
                _saveTasks();
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _markTaskAsCompleted(int index) {
    setState(() {
      completed[index] = true;
      completedTasks.add(todotasks[index]);
      todotasks.removeAt(index);
      completed.removeAt(index);
    });
    _saveTasks();
  }
}
