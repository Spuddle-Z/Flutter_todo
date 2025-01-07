import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  String taskContent;
  @HiveField(1)
  bool taskDone;
  @HiveField(2)
  int taskPriority;

  Task({
    required this.taskContent,
    required this.taskDone,
    required this.taskPriority,
  });
}
