import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/task.dart';
import 'package:todoey_flutter/screens/eater_egg_screen.dart';
import 'package:todoey_flutter/services/hive_helper.dart';
import 'package:todoey_flutter/widgets/task_tile.dart';

import '../constants.dart';

class ListViewCard extends StatelessWidget {
  ListViewCard({this.index, this.key});
  final int index;
  final Key key;

  @override
  Widget build(BuildContext context) {
    return Consumer<HiveHelper>(builder: (context, hiveHelper, Widget child) {
      Task task = hiveHelper.getTask(index);
      return TaskTile(
        task: task,
        onChangedFunction: (checkboxState) async {
          await hiveHelper.toggleDoneState(index);
          if (hiveHelper.allBoxesTicked(hiveHelper)) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return EasterEggScreen(
                  eggTrigger: EasterEggs.AllDone,
                );
              },
            );
          }
        },
      );
    });
  }
}
