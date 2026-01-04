import 'package:hive/hive.dart';
part 'routine_model.g.dart';

@HiveType(typeId: 1)
class Routine {
  @HiveField(0)
  final String content;
  @HiveField(1)
  DateTime? date;

  Routine({
    required this.content,
    this.date,
  });

  Routine.copy(Routine routine)
      : content = routine.content,
        date = routine.date;
}
