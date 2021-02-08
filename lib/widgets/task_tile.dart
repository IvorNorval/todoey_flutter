import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todoey_flutter/models/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({this.onChangedFunction, this.task});
  final void Function(bool) onChangedFunction;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(4),
      color: Colors.white,
      child: InkWell(
        splashColor: const Color(0xff197278),
        onTap: () => Fluttertoast.showToast(
            msg: "Item selected.", toastLength: Toast.LENGTH_SHORT),
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
                      task.taskText,
                      style: TextStyle(
                        decoration:
                            task.isDone ? TextDecoration.lineThrough : null,
                        color: const Color(0xFF283d3b),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Checkbox(
                value: task.isDone,
                activeColor: const Color(0xfFc44900),
                onChanged: onChangedFunction,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
