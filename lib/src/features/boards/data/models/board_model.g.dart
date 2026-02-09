// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BoardModelAdapter extends TypeAdapter<BoardModel> {
  @override
  final typeId = 1;

  @override
  BoardModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BoardModel(
      id: fields[0] == null ? '' : fields[0] as String,
      title: fields[1] == null ? '' : fields[1] as String,
      description: fields[2] == null ? '' : fields[2] as String,
      members: fields[3] == null
          ? const []
          : (fields[3] as List).cast<String>(),
      tasks: fields[4] == null ? const [] : (fields[4] as List).cast<String>(),
      taskModels: fields[5] == null
          ? const []
          : (fields[5] as List).cast<TaskModel>(),
      createdBy: fields[6] == null ? '' : fields[6] as String,
      createdAt: fields[7] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, BoardModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.members)
      ..writeByte(4)
      ..write(obj.tasks)
      ..writeByte(5)
      ..write(obj.taskModels)
      ..writeByte(6)
      ..write(obj.createdBy)
      ..writeByte(7)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoardModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
