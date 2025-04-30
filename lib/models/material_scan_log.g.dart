// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_scan_log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MaterialScanLogAdapter extends TypeAdapter<MaterialScanLog> {
  @override
  final int typeId = 0;

  @override
  MaterialScanLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MaterialScanLog(
      materialName: fields[0] as String,
      unitCost: fields[1] as double,
      unitType: fields[2] as String,
      stock: fields[3] as int,
      scannedAt: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MaterialScanLog obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.materialName)
      ..writeByte(1)
      ..write(obj.unitCost)
      ..writeByte(2)
      ..write(obj.unitType)
      ..writeByte(3)
      ..write(obj.stock)
      ..writeByte(4)
      ..write(obj.scannedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MaterialScanLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
