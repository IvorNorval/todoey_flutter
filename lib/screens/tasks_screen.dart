import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todoey_flutter/models/task.dart';
import 'package:todoey_flutter/screens/eater_egg_screen.dart';
import 'package:todoey_flutter/services/hive_helper.dart';
import 'package:todoey_flutter/widgets/list_view_card.dart';

class TasksScreen extends StatelessWidget {
  static const String id = 'TasksScreen';
  @override
  Widget build(BuildContext context) {
    String newTaskTitle;
    int listCount = 0;
    final TextEditingController _controller = new TextEditingController();
    return Consumer<HiveHelper>(
      builder: (context, hiveHelper, Widget child) {
        return Scaffold(
          backgroundColor: Color(0xff197278),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xffc44536),
            onPressed: () {
              if (newTaskTitle != null) {
                final newTask = Task(taskText: newTaskTitle, isDone: false);
                hiveHelper.addTask(newTask);
              }
              _controller.clear();
              FocusScope.of(context).requestFocus(FocusNode());
              newTaskTitle = null;
              listCount = hiveHelper.getTaskBoxLength();
            },
            child: Icon(
              Icons.add,
              color: Color(0xffedddd4),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Shimmer.fromColors(
                      baseColor: Color(0xFFedddd4),
                      period: Duration(milliseconds: 5000),
                      highlightColor: Color(0xFF283d3b),
                      child: Text(
                        'ToDoey',
                        style: TextStyle(
                          color: Color(0xFFedddd4),
                          fontSize: 30.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      '${hiveHelper.getTaskBoxLength()} todo\'s',
                      style: TextStyle(
                        color: Color(0xFFedddd4),
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFedddd4),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: ReorderableListView(
                    onReorder: hiveHelper.moveTask,
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    children: List.generate(
                      hiveHelper.getTaskBoxLength(),
                      (index) {
                        return Dismissible(
                          key: Key(hiveHelper.getTask(index).taskText),
                          onDismissed: (direction) async {
                            await hiveHelper.deleteTask(index);
                            if (hiveHelper.getTaskBoxLength() == 0 && listCount == 1) {
                              listCount = hiveHelper.getTaskBoxLength();
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return EasterEggScreen();
                                },
                              );
                            }
                            listCount = hiveHelper.getTaskBoxLength();
                          },
                          background: Container(
                            color: Color(0xfFc44900),
                          ),
                          child: ListViewCard(
                            index: index,
                            key: Key('$index'),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Container(
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
                        listCount = hiveHelper.getTaskBoxLength();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
