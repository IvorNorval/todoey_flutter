import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoey_flutter/widgets/heading_widget.dart';
import 'package:todoey_flutter/widgets/task_list_widget.dart';
import 'package:todoey_flutter/widgets/task_text_field_widget.dart';

class TasksScreen extends StatelessWidget {
  static const String id = 'TasksScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff197278),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Heading(),
          TaskListWidget(),
          TaskTextFieldWidget(),
        ],
      ),
    );
  }
}
