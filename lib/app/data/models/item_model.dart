import 'package:hive/hive.dart';
part 'item_model.g.dart';

@HiveType(typeId: 0)
class Item {
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

  Item({
    required this.isTask,
    required this.content,
    this.date,
    this.recurrence,
    this.priority,
    this.difficulty,
    required this.note,
  });

  Item.copy(Item item)
      : isTask = item.isTask,
        content = item.content,
        done = item.done,
        date = item.date,
        recurrence = item.recurrence,
        priority = item.priority,
        difficulty = item.difficulty,
        note = item.note;
}
