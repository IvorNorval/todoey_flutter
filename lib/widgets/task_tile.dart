import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todoey_flutter/models/task.dart';

class TaskTile extends StatelessWidget {
  TaskTile({this.onChangedFunction, this.task});
  final Function onChangedFunction;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(4),
      color: Colors.white,
      child: InkWell(
        splashColor: Color(0xff197278),
        onTap: () => Fluttertoast.showToast(msg: "Item selected.", toastLength: Toast.LENGTH_SHORT),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      //Provider.of<TaskListModel>(context).tasks[0].taskText,
                      task.taskText,
                      style: TextStyle(decoration: task.isDone ? TextDecoration.lineThrough : null, color: Color(0xFF283d3b)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Checkbox(
                value: task.isDone,
                activeColor: Color(0xFF283d3b),
                onChanged: onChangedFunction,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
