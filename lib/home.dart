import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'todoTasks.dart';
import 'completedTasks.dart';

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
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       DrawerHeader(
      //         decoration: const BoxDecoration(color: Colors.pinkAccent),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             const Text(
      //               "Menu",
      //               style: TextStyle(fontSize: 20.0, color: Colors.white),
      //             ),
      //             Divider(
      //               color: Color.fromARGB(255, 255, 116, 162),
      //             ),
      //             const SizedBox(height: 10),
      //             Padding(
      //               padding: const EdgeInsets.all(8.0),
      //               child: Row(
      //                 children: [
      //                   Column(
      //                     children: [
      //                       const Icon(
      //                         Icons.pending_actions,
      //                         color: Colors.white,
      //                         size: 35.0,
      //                       ),
      //                       Text(
      //                         '${_getPendingTaskCount()} tasks',
      //                         style: const TextStyle(color: Colors.white),
      //                       ),
      //                     ],
      //                   ),
      //                   const SizedBox(width: 20),
      //                   Column(
      //                     children: [
      //                       const Icon(
      //                         Icons.done,
      //                         color: Colors.white,
      //                         size: 35.0,
      //                       ),
      //                       Text(
      //                         '${_getCompletedTaskCount()} tasks',
      //                         style: const TextStyle(color: Colors.white),
      //                       ),
      //                     ],
      //                   ),
      //                   const SizedBox(width: 20),
      //                   const Column(
      //                     children: [
      //                       Icon(
      //                         Icons.account_circle,
      //                         color: Colors.white,
      //                         size: 35.0,
      //                       ),
      //                       Text(
      //                         "Account",
      //                         style: TextStyle(color: Colors.white),
      //                       ),
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //             )
      //           ],
      //         ),
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.home),
      //         title: const Text("Home"),
      //         onTap: () => Navigator.pop(context),
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.pending_actions),
      //         title: const Text("To-do tasks"),
      //         onTap: () {
      //           Navigator.pop(context);
      //           Navigator.pushNamed(
      //             context,
      //             '/todotasks',
      //             arguments: {
      //               'todotasks': todotasks,
      //               'onTaskComplete': _markTaskAsCompleted,
      //             },
      //           );
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.done),
      //         title: const Text("Completed tasks"),
      //         onTap: () {
      //           Navigator.pop(context);
      //           Navigator.pushNamed(
      //             context,
      //             '/completedtasks',
      //             arguments: completedTasks,
      //           );
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.settings),
      //         title: const Text("Settings"),
      //         onTap: () => Navigator.pop(context),
      //       ),
      //     ],
      //   ),
      // ),
      body: todotasks.isEmpty && completedTasks.isEmpty
          ? const Center(
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
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
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
                                style: const TextStyle(fontSize: 18.0),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, size: 19.0),
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
                          if (index != completedTasks.length - 1)
                            const Divider()
                        ],
                      );
                    },
                  ),
                ],
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(
              Icons.home,
              size: 35.0,
              color: Colors.pinkAccent,
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        tooltip: 'Add task',
        backgroundColor: const Color.fromARGB(255, 255, 111, 159),
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
