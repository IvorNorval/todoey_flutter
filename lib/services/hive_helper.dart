import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:todoey_flutter/models/task.dart';

import '../constants.dart';

class HiveHelper extends ChangeNotifier {
  ScrollController scrollController = ScrollController();
  late bool isInfoList;
  List<Task> infoTasks = [];
  late bool showAd;

  HiveHelper() {
    isInfoList = false;
    showAd = true;
  }

  void setShowAd() {
    showAd = true;
    notifyListeners();
  }

  void hideAd() {
    showAd = false;
    notifyListeners();
  }

  Box<Task?> getTaskBox() => Hive.box('tasks');

  void setInfoList() {
    isInfoList = true;
    infoTasks.clear();
    infoTasks.addAll(kFirstList);
    for (final Task tk in infoTasks) {
      tk.isDone = false;
    }
    notifyListeners();
  }

  void resetInfoList() {
    isInfoList = false;
    notifyListeners();
  }

  int getTaskBoxLength() {
    if (isInfoList) {
      return infoTasks.length;
    } else {
      return getTaskBox().length;
    }
  }

  Task? getTask(int? index) {
    if (isInfoList) {
      return infoTasks[index!];
    } else {
      return getTaskBox().getAt(index!);
    }
  }

  dynamic getGlobalKey(int index) {
    if (isInfoList) {
      return index;
    } else {
      return getTaskBox().keyAt(index);
    }
  }

  void addTask(Task newTask) {
    if (isInfoList) {
      infoTasks.add(newTask);
    } else {
      getTaskBox().add(newTask);
    }
    notifyListeners();
  }

  int getDoneTasksCount() {
    int count = 0;
    if (isInfoList) {
      for (final Task task in infoTasks) {
        if (task.isDone!) {
          count++;
        }
      }
    } else {
      final List<Task?> taskList = getTaskList();

      for (final Task? task in taskList) {
        if (task!.isDone!) {
          count++;
        }
      }
    }
    return count;
  }

  List<Task?> getTaskList() {
    final List<Task?> taskList = [];
    for (int n = 0; n < getTaskBoxLength(); n++) {
      taskList.add(getTask(n));
    }
    return taskList;
  }

  Future<void> deleteTask(int index) async {
    if (isInfoList) {
      infoTasks.removeAt(index);
    } else {
      await getTaskBox().deleteAt(index);
    }
    notifyListeners();
  }

  Future<void> deleteAllTask() async {
    final keys = getTaskBox().keys;
    await getTaskBox().deleteAll(keys);
    notifyListeners();
  }

  Future<void> toggleDoneState(int? index) async {
    if (isInfoList) {
      infoTasks[index!].isDone = !infoTasks[index].isDone!;
    } else {
      final Task task = getTask(index)!;
      task.isDone = !task.isDone!;
      await getTaskBox().putAt(index!, task);
    }
    notifyListeners();
  }

  Future<void> updateColor(int? index, int color) async {
    if (isInfoList) {
      infoTasks[index!].color = color;
    } else {
      final Task task = getTask(index)!;
      task.color = color;
      await getTaskBox().putAt(index!, task);
    }
    notifyListeners();
  }

  Future<void> moveTask(int oldIndex, int newIndex) async {
    int index = newIndex;
    if (newIndex > oldIndex) {
      index -= 1;
    }

    if (isInfoList) {
      final Task item = infoTasks.removeAt(oldIndex);
      infoTasks.insert(index, item);
    } else {
      final List<Task?> list = getTaskList();
      final Task? item = list.removeAt(oldIndex);
      list.insert(index, item);
      deleteAllTask();
      getTaskBox().addAll(list);
    }
    notifyListeners();
  }

  bool allBoxesTicked() {
    bool allTicked = true;
    if (isInfoList) {
      for (final Task tk in infoTasks) {
        if (!tk.isDone!) {
          allTicked = false;
          break;
        }
      }
    } else {
      for (final Task? tk in getTaskList()) {
        if (!tk!.isDone!) {
          allTicked = false;
          break;
        }
      }
    }

    return allTicked;
  }
}
