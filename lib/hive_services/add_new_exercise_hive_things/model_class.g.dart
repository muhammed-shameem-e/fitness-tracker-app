// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddNewExerciseModelClassAdapter
    extends TypeAdapter<AddNewExerciseModelClass> {
  @override
  final int typeId = 7;

  @override
  AddNewExerciseModelClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddNewExerciseModelClass(
      addAllExerciseId: fields[0] as int,
      execiseName: fields[1] as String,
      execiseGif: fields[2] as String,
      exerciseBenefit: fields[4] as String,
      exerciseReps: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AddNewExerciseModelClass obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.addAllExerciseId)
      ..writeByte(1)
      ..write(obj.execiseName)
      ..writeByte(2)
      ..write(obj.execiseGif)
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
      other is AddNewExerciseModelClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
