// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'abs_exercise_model_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AbsExerciseModelClassAdapter extends TypeAdapter<AbsExerciseModelClass> {
  @override
  final int typeId = 4;

  @override
  AbsExerciseModelClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AbsExerciseModelClass(
      absId: fields[0] as int?,
      absExerciseGif: fields[1] as String,
      absExerciseName: fields[2] as String,
      absreps: fields[3] as String,
      absExerciseBenefit: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AbsExerciseModelClass obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.absId)
      ..writeByte(1)
      ..write(obj.absExerciseGif)
      ..writeByte(2)
      ..write(obj.absExerciseName)
      ..writeByte(3)
      ..write(obj.absreps)
      ..writeByte(4)
      ..write(obj.absExerciseBenefit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AbsExerciseModelClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
