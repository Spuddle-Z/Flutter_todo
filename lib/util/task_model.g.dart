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
      taskContent: fields[1] as String,
      taskPriority: fields[3] as int,
      taskDue: fields[4] as DateTime?,
      taskNote: fields[5] as String,
      taskRecurrence: fields[6] as Duration?,
    )
      ..id = fields[0] as String
      ..taskDone = fields[2] as bool;
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.taskContent)
      ..writeByte(2)
      ..write(obj.taskDone)
      ..writeByte(3)
      ..write(obj.taskPriority)
      ..writeByte(4)
      ..write(obj.taskDue)
      ..writeByte(5)
      ..write(obj.taskNote)
      ..writeByte(6)
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
