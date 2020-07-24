import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  Task({this.taskText, this.isDone});
  @HiveField(0)
  final String taskText;
  @HiveField(1)
  final bool isDone;
}
