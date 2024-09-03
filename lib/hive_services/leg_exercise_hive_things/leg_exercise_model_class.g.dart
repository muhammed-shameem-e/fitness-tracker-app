// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leg_exercise_model_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LegExerciseModelClassAdapter extends TypeAdapter<LegExerciseModelClass> {
  @override
  final int typeId = 5;

  @override
  LegExerciseModelClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LegExerciseModelClass(
      legId: fields[0] as int?,
      legExerciseGif: fields[1] as String,
      legExerciseName: fields[2] as String,
      legreps: fields[3] as String,
      legExerciseBenefit: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LegExerciseModelClass obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.legId)
      ..writeByte(1)
      ..write(obj.legExerciseGif)
      ..writeByte(2)
      ..write(obj.legExerciseName)
      ..writeByte(3)
      ..write(obj.legreps)
      ..writeByte(4)
      ..write(obj.legExerciseBenefit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LegExerciseModelClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
