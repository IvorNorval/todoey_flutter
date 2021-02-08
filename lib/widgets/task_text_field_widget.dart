import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/task.dart';
import 'package:todoey_flutter/screens/eater_egg_screen.dart';
import 'package:todoey_flutter/services/hive_helper.dart';

class TaskTextFieldWidget extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String newTaskTitle;
    return Consumer<HiveHelper>(
      builder: (context, hiveHelper, Widget child) {
        return Container(
          color: const Color(0xFFedddd4),
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: const BoxDecoration(
              color: Color(0xFF283d3b),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFedddd4),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: TextField(
                controller: _controller,
                textInputAction: TextInputAction.go,
                cursorColor: const Color(0xFF283d3b),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
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
                        return EasterEggScreen();
                      },
                    );
                  }
                  if (hiveHelper.getTaskBoxLength() > 9) {
                    hiveHelper.scrollController.animateTo(
                      hiveHelper.scrollController.position.maxScrollExtent,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 300),
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
