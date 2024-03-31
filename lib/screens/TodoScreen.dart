import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:pema_la/data/database.dart';
import 'package:pema_la/utilit_of_ToDo/dialog_box.dart';
import 'package:pema_la/utilit_of_ToDo/todo_tile.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
//reference the hive box
  final _myBox = Hive.box('mybox');

//database
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // if this is the 1st time opening the app ,then have to create the default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      //if the user is already there it will simply load the data
      db.loadData();
    }

    super.initState();
  }

//text controller
  final _controller = TextEditingController();

  //list of the task that has to be done

  //checkbox was tapped
  void checkBoxchanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  // Save new Task
  void saveNewTask() {
    setState(() {
      //adding to the todoList and false is for saying that the yet the task is not done
      db.toDoList.add([_controller.text, false]);

      //the below code is for clearming the text we have written earlier in th etexfield
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  //create a new Task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        // the DialogBox is called from the dialogbox.dart
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  //function for delete Task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
     db.updateDataBase(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF7E5E7),
        appBar: AppBar(
           centerTitle: true,
          title: Text("To Do", style:TextStyle(fontWeight: FontWeight.w700), ),
          elevation: 0,
          backgroundColor: Color(0xFFFFC2CD),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: Icon(Icons.add),
          backgroundColor: Color(0xFFFFC2CD),
        ),
        body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxchanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          },
        ));
  }
}
