import 'package:hive/hive.dart';
part 'trivia_model.g.dart';

@HiveType(typeId: 0)
class Trivia {
  @HiveField(0)
  String content;
  @HiveField(1)
  bool done = false;
  @HiveField(2)
  int difficulty;
  @HiveField(3)
  String note;

  Trivia({
    required this.content,
    required this.difficulty,
    required this.note,
  });
}
