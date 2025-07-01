import 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  String content;
  @HiveField(1)
  bool done = false;
  @HiveField(2)
  int recurrence;
  @HiveField(3)
  DateTime? date;
  @HiveField(4)
  int priority;
  @HiveField(5)
  String note;

  Task({
    required this.content,
    required this.priority,
    this.date,
    required this.note,
    required this.recurrence,
  });

  Task.copy(Task task)
      : content = task.content,
        done = task.done,
        priority = task.priority,
        date = task.date,
        note = task.note,
        recurrence = task.recurrence;
}
