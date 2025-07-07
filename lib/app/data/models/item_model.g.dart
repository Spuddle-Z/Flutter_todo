// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemAdapter extends TypeAdapter<Item> {
  @override
  final int typeId = 0;

  @override
  Item read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Item(
      isTask: fields[0] as bool,
      content: fields[1] as String,
      date: fields[4] as DateTime?,
      recurrence: fields[3] as int?,
      priority: fields[5] as int?,
      difficulty: fields[6] as int?,
      note: fields[7] as String,
    )..done = fields[2] as bool;
  }

  @override
  void write(BinaryWriter writer, Item obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.isTask)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.done)
      ..writeByte(3)
      ..write(obj.recurrence)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.priority)
      ..writeByte(6)
      ..write(obj.difficulty)
      ..writeByte(7)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
