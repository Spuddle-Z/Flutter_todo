// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trivia_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TriviaAdapter extends TypeAdapter<Trivia> {
  @override
  final int typeId = 0;

  @override
  Trivia read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Trivia(
      content: fields[0] as String,
      difficulty: fields[2] as int,
      note: fields[3] as String,
    )..done = fields[1] as bool;
  }

  @override
  void write(BinaryWriter writer, Trivia obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.content)
      ..writeByte(1)
      ..write(obj.done)
      ..writeByte(2)
      ..write(obj.difficulty)
      ..writeByte(3)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TriviaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
