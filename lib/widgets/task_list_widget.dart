import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/screens/eater_egg_screen.dart';
import 'package:todoey_flutter/services/hive_helper.dart';

import '../constants.dart';
import 'list_view_card.dart';

class TaskListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HiveHelper>(
      builder: (context, hiveHelper, Widget child) {
        return Expanded(
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
                      int listCount = hiveHelper.getTaskBoxLength();
                      await hiveHelper.deleteTask(index);
                      if (hiveHelper.getTaskBoxLength() == 0 && listCount == 1) {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return EasterEggScreen(
                              eggTrigger: EasterEggs.noTasks,
                            );
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
        );
      },
    );
  }
}
