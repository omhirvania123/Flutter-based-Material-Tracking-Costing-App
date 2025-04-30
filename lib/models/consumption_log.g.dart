// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumption_log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConsumptionLogAdapter extends TypeAdapter<ConsumptionLog> {
  @override
  final int typeId = 1;

  @override
  ConsumptionLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConsumptionLog(
      materialName: fields[0] as String,
      unitCost: fields[1] as double,
      unitType: fields[2] as String,
      quantityUsed: fields[3] as double,
      totalCost: fields[4] as double,
      manufacturingCost: fields[5] as double,
      finalProductPrice: fields[6] as double,
      suggestedSellingPricePerUnit: fields[7] as double,
      profitMarginPerUnit: fields[8] as double,
      loggedAt: fields[9] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ConsumptionLog obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.materialName)
      ..writeByte(1)
      ..write(obj.unitCost)
      ..writeByte(2)
      ..write(obj.unitType)
      ..writeByte(3)
      ..write(obj.quantityUsed)
      ..writeByte(4)
      ..write(obj.totalCost)
      ..writeByte(5)
      ..write(obj.manufacturingCost)
      ..writeByte(6)
      ..write(obj.finalProductPrice)
      ..writeByte(7)
      ..write(obj.suggestedSellingPricePerUnit)
      ..writeByte(8)
      ..write(obj.profitMarginPerUnit)
      ..writeByte(9)
      ..write(obj.loggedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConsumptionLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
