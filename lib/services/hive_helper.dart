import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:todoey_flutter/models/task.dart';

class HiveHelper extends ChangeNotifier {
  Box<Task> getTaskBox() => Hive.box('tasks');

  int getTaskBoxLength() => getTaskBox().length;

  Task getTask(int index) => getTaskBox().getAt(index);

  void addTask(Task newTask) {
    getTaskBox().add(newTask);
    notifyListeners();
  }

  List<Task> getTaskList() {
    List<Task> taskList = [];
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
    var keys = getTaskBox().keys;
    await getTaskBox().deleteAll(keys);
    notifyListeners();
  }

  Future<void> toggleDoneState(int index) async {
    Task task = getTask(index);
    Task newTask;
    newTask = Task(taskText: task.taskText, isDone: !task.isDone);
    await getTaskBox().putAt(index, newTask);
    notifyListeners();
  }

  Future<void> moveTask(int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    List<Task> list = getTaskList();
    final Task item = list.removeAt(oldIndex);
    list.insert(newIndex, item);
    deleteAllTask();
    getTaskBox().addAll(list);
    notifyListeners();
  }
}
