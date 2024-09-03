// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_model_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoriesModelClassAdapter extends TypeAdapter<CategoriesModelClass> {
  @override
  final int typeId = 6;

  @override
  CategoriesModelClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoriesModelClass(
      categoriesId: fields[0] as int?,
      categoriesImage: fields[1] as String,
      categoriesName: fields[2] as String,
      exerSizeIds: (fields[3] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, CategoriesModelClass obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.categoriesId)
      ..writeByte(1)
      ..write(obj.categoriesImage)
      ..writeByte(2)
      ..write(obj.categoriesName)
      ..writeByte(3)
      ..write(obj.exerSizeIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoriesModelClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
