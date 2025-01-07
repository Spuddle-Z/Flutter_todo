import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  String task_content;
  @HiveField(1)
  bool task_done;
  @HiveField(2)
  int task_priority;

  Task({
    required this.task_content,
    required this.task_done,
    required this.task_priority,
  });
}
