// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      taskContent: fields[0] as String,
      taskPriority: fields[2] as int,
      taskDue: fields[3] as DateTime?,
      taskNote: fields[4] as String,
      taskRecurrence: fields[5] as String,
    )..taskDone = fields[1] as bool;
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.taskContent)
      ..writeByte(1)
      ..write(obj.taskDone)
      ..writeByte(2)
      ..write(obj.taskPriority)
      ..writeByte(3)
      ..write(obj.taskDue)
      ..writeByte(4)
      ..write(obj.taskNote)
      ..writeByte(5)
      ..write(obj.taskRecurrence);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
