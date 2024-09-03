// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsersDataAdapter extends TypeAdapter<UsersData> {
  @override
  final int typeId = 1;

  @override
  UsersData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UsersData(
      id: fields[0] as int?,
      name: fields[1] as String,
      age: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UsersData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.age);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsersDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
