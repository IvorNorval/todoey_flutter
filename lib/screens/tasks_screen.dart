import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/services/hive_helper.dart';
import 'package:todoey_flutter/widgets/heading_widget.dart';
import 'package:todoey_flutter/widgets/task_list_widget.dart';
import 'package:todoey_flutter/widgets/task_text_field_widget.dart';

class TasksScreen extends StatelessWidget {
  static const String id = 'TasksScreen';
  @override
  Widget build(BuildContext context) {
    return Consumer<HiveHelper>(
      builder: (context, hiveHelper, Widget child) {
        if (MediaQuery.of(context).orientation == Orientation.landscape) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: const Color(0xff197278),
              body: Row(
                children: [
                  SizedBox(
                    width: 180,
                    child: Heading(),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TaskListWidget(),
                        TaskTextFieldWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: const Color(0xff197278),
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
      },
    );
  }
}
