// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MentalModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MentalModelAdapter extends TypeAdapter<MentalModel> {
  @override
  final int typeId = 0;

  @override
  MentalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MentalModel()
      ..deepBreathing = fields[0] as int
      ..imageryMeditation = fields[1] as int
      ..bodyScan = fields[2] as int
      ..mindfulBreathing = fields[3] as int
      ..muscleRelaxation = fields[4] as int
      ..freeformMeditation = fields[5] as int;
  }

  @override
  void write(BinaryWriter writer, MentalModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.deepBreathing)
      ..writeByte(1)
      ..write(obj.imageryMeditation)
      ..writeByte(2)
      ..write(obj.bodyScan)
      ..writeByte(3)
      ..write(obj.mindfulBreathing)
      ..writeByte(4)
      ..write(obj.muscleRelaxation)
      ..writeByte(5)
      ..write(obj.freeformMeditation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MentalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
