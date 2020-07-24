import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/task.dart';
import 'package:todoey_flutter/services/hive_helper.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String newTaskTitle;
    return Consumer<HiveHelper>(
      builder: (context, hiveHelper, Widget child) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            color: Color(0xFF757575),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Add Task',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  TextField(
                    autofocus: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      newTaskTitle = value;
                    },
                    onEditingComplete: () {
                      if (newTaskTitle != null) {
                        final newTask = Task(taskText: newTaskTitle, isDone: false);
                        hiveHelper.addTask(newTask);
                      }
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  FlatButton(
                    color: Colors.lightBlueAccent,
                    padding: EdgeInsets.all(15.0),
                    splashColor: Colors.blueAccent,
                    onPressed: () {
                      if (newTaskTitle != null) {
                        final newTask = Task(taskText: newTaskTitle, isDone: false);
                        hiveHelper.addTask(newTask);
                      }
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Add ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
