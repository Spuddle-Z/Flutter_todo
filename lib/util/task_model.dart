import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  String id = const Uuid().v4();
  @HiveField(1)
  String taskContent;
  @HiveField(2)
  bool taskDone = false;
  @HiveField(3)
  int taskPriority;
  @HiveField(4)
  DateTime? taskDue;
  @HiveField(5)
  String taskNote;
  @HiveField(6)
  Duration? taskRecurrence;

  Task({
    required this.taskContent,
    required this.taskPriority,
    this.taskDue,
    required this.taskNote,
    this.taskRecurrence,
  });
}
