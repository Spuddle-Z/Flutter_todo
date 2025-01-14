import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  String taskContent;
  @HiveField(1)
  bool taskDone = false;
  @HiveField(2)
  int taskPriority;
  @HiveField(3)
  DateTime? taskDue;
  @HiveField(4)
  String taskNote;
  @HiveField(5)
  String taskRecurrence;

  Task({
    required this.taskContent,
    required this.taskPriority,
    this.taskDue,
    required this.taskNote,
    required this.taskRecurrence,
  });

  Task.copy(Task task)
    : taskContent = task.taskContent,
      taskDone = task.taskDone,
      taskPriority = task.taskPriority,
      taskDue = task.taskDue,
      taskNote = task.taskNote,
      taskRecurrence = task.taskRecurrence;
}
