// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upperbody_exercise_model_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UpperBodyExercisesModelClassAdapter
    extends TypeAdapter<UpperBodyExercisesModelClass> {
  @override
  final int typeId = 3;

  @override
  UpperBodyExercisesModelClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UpperBodyExercisesModelClass(
      upperBodyId: fields[0] as int?,
      upperBodyExerciseName: fields[1] as String,
      upperBodyExerciseGif: fields[2] as String,
      upperBodyExerciseBenefit: fields[4] as String,
      upperBodyReps: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UpperBodyExercisesModelClass obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.upperBodyId)
      ..writeByte(1)
      ..write(obj.upperBodyExerciseName)
      ..writeByte(2)
      ..write(obj.upperBodyExerciseGif)
      ..writeByte(3)
      ..write(obj.upperBodyReps)
      ..writeByte(4)
      ..write(obj.upperBodyExerciseBenefit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpperBodyExercisesModelClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
