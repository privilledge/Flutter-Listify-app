import 'package:flutter/material.dart';

void main()=>runApp(TodoApp());

class TodoApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     title: 'Todo app',
     theme: ThemeData(primarySwatch:Colors.lightBlue),
     home: TodoListScreen(),

   );
  }
}

class TodoListScreen extends StatefulWidget{
  @override
  _TodoListScreenState createState()=>_TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen>{
List<String> tasks=[];

@override
  Widget build(BuildContext context){
  return Scaffold(
      appBar:AppBar(title:Text( 'Todo App',style: TextStyle(color: Colors.white),),backgroundColor: Colors.blueGrey),
  body:ListView.builder(itemCount: tasks.length,itemBuilder: (context,index){
  return ListTile(
  title:Text(tasks[index]),
  );
  },
  ),
  floatingActionButton: FloatingActionButton(
    onPressed:(){ _showAddTaskDialog(context);},
    tooltip: 'Add task',
    child: Icon(Icons.add),
  ),
  );
  }

 void _showAddTaskDialog(BuildContext context){
  TextEditingController _taskController=TextEditingController();

  showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
      title: Text('Add text'),
      content: TextField(
        controller: _taskController,
        decoration: InputDecoration(hintText: 'Enter task'),
      ),
      actions: [
        TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text('Cancel')),
        TextButton( child: Text('Add'),onPressed: (){
          setState(() {
            tasks.add(_taskController.text);
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
