import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/task.dart';
import 'package:todoey_flutter/screens/eater_egg_screen.dart';
import 'package:todoey_flutter/services/hive_helper.dart';

import '../constants.dart';

class TaskTextFieldWidget extends StatelessWidget {
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    String newTaskTitle;
    return Consumer<HiveHelper>(
      builder: (context, hiveHelper, Widget child) {
        return Container(
          color: Color(0xFFedddd4),
          child: Container(
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: Color(0xFF283d3b),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFedddd4),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: TextField(
                controller: _controller,
                textInputAction: TextInputAction.go,
                cursorColor: Color(0xFF283d3b),
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                    hintText: 'Add new to do...',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff197278),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff197278),
                      ),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff197278),
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Color(0xff197278),
                    )),
                onChanged: (value) {
                  newTaskTitle = value;
                },
                onEditingComplete: () {
                  if (newTaskTitle != null) {
                    final newTask = Task(taskText: newTaskTitle, isDone: false);
                    hiveHelper.addTask(newTask);
                  }
                  FocusScope.of(context).requestFocus(FocusNode());
                  _controller.clear();
                  newTaskTitle = null;
                  if (hiveHelper.getTaskBoxLength() == 10) {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return EasterEggScreen(
                          eggTrigger: EasterEggs.manyBoxes,
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
