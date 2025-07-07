import 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  bool isTask;
  @HiveField(1)
  String content;
  @HiveField(2)
  bool done = false;
  @HiveField(3)
  int? recurrence;
  @HiveField(4)
  DateTime? date;
  @HiveField(5)
  int? priority;
  @HiveField(6)
  int? difficulty;
  @HiveField(7)
  String note;

  Task({
    required this.isTask,
    required this.content,
    this.date,
    this.recurrence,
    this.priority,
    this.difficulty,
    required this.note,
  });

  Task.copy(Task task)
      : isTask = task.isTask,
        content = task.content,
        done = task.done,
        date = task.date,
        recurrence = task.recurrence,
        priority = task.priority,
        difficulty = task.difficulty,
        note = task.note;
}
