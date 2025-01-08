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
  @HiveField(3)
  DateTime? taskDue;
  @HiveField(4)
  String? taskNote;
  @HiveField(5)
  Duration? taskRecurrence;

  Task({
    required this.taskContent,
    required this.taskDone,
    required this.taskPriority,
    this.taskDue,
    this.taskNote,
    this.taskRecurrence,
  });
}
