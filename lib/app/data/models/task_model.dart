import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  String taskContent;
  @HiveField(1)
  bool taskDone = false;
  @HiveField(2)
  int taskRecurrence;
  @HiveField(3)
  DateTime? taskDate;
  @HiveField(4)
  int taskPriority;
  @HiveField(5)
  String taskNote;

  Task({
    required this.taskContent,
    required this.taskPriority,
    this.taskDate,
    required this.taskNote,
    required this.taskRecurrence,
  });

  Task.copy(Task task)
      : taskContent = task.taskContent,
        taskDone = task.taskDone,
        taskPriority = task.taskPriority,
        taskDate = task.taskDate,
        taskNote = task.taskNote,
        taskRecurrence = task.taskRecurrence;
}
