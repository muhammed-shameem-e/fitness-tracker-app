// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreateUserPlanAdapter extends TypeAdapter<CreateUserPlan> {
  @override
  final int typeId = 10;

  @override
  CreateUserPlan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CreateUserPlan(
      id: fields[0] as int?,
      exerciseName: fields[1] as String,
      exerciseGif: fields[2] as String,
      exerciseBenefit: fields[4] as String,
      exerciseReps: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CreateUserPlan obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.exerciseName)
      ..writeByte(2)
      ..write(obj.exerciseGif)
      ..writeByte(3)
      ..write(obj.exerciseReps)
      ..writeByte(4)
      ..write(obj.exerciseBenefit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateUserPlanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
