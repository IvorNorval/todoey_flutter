import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:todoey_flutter/models/task.dart';

class HiveHelper extends ChangeNotifier {
  ScrollController scrollController = ScrollController();

  Box<Task> getTaskBox() => Hive.box('tasks');

  int getTaskBoxLength() => getTaskBox().length;

  Task getTask(int index) => getTaskBox().getAt(index);

  dynamic getGlobalKey(int index) => getTaskBox().keyAt(index);

  void addTask(Task newTask) {
    getTaskBox().add(newTask);
    notifyListeners();
  }

  int getDoneTasksCount() {
    final List<Task> taskList = getTaskList();
    int count = 0;
    for (final Task task in taskList) {
      if (task.isDone) {
        count++;
      }
    }
    return count;
  }

  List<Task> getTaskList() {
    final List<Task> taskList = [];
    for (int n = 0; n < getTaskBoxLength(); n++) {
      taskList.add(getTask(n));
    }
    return taskList;
  }

  Future<void> deleteTask(int index) async {
    await getTaskBox().deleteAt(index);
    notifyListeners();
  }

  Future<void> deleteAllTask() async {
    final keys = getTaskBox().keys;
    await getTaskBox().deleteAll(keys);
    notifyListeners();
  }

  Future<void> toggleDoneState(int index) async {
    final Task task = getTask(index);
    task.isDone = !task.isDone;
    await getTaskBox().putAt(index, task);
    notifyListeners();
  }

  Future<void> updateColor(int index, int color) async {
    final Task task = getTask(index);
    task.color = color;
    await getTaskBox().putAt(index, task);
    notifyListeners();
  }

  Future<void> moveTask(int oldIndex, int newIndex) async {
    int index = newIndex;
    if (newIndex > oldIndex) {
      index -= 1;
    }
    final List<Task> list = getTaskList();
    final Task item = list.removeAt(oldIndex);
    list.insert(index, item);
    deleteAllTask();
    getTaskBox().addAll(list);
    notifyListeners();
  }

  bool allBoxesTicked() {
    bool allTicked = true;
    for (final Task tk in getTaskList()) {
      if (!tk.isDone) {
        allTicked = false;
        break;
      }
    }
    return allTicked;
  }
}
