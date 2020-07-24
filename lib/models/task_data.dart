import 'package:flutter/foundation.dart';
import 'package:todoey_flutter/models/task.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [];

  void addTask({String taskString}) {
    _tasks.add(Task(taskText: taskString));
    notifyListeners();
  }

  void taskDone(int index) {
    //_tasks[index].isDone = !_tasks[index].isDone;
    notifyListeners();
  }

  int getTasksCount() => _tasks.length;

  Task getTask(int index) => _tasks[index];

  void deleteTask(index) {
    _tasks.removeAt(index);
    notifyListeners();
  }
}
