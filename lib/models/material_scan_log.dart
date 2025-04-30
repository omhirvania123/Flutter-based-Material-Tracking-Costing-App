import 'package:hive/hive.dart';

part 'material_scan_log.g.dart';

@HiveType(typeId: 0)
class MaterialScanLog extends HiveObject {
  @HiveField(0)
  String materialName;
  @HiveField(1)
  double unitCost;
  @HiveField(2)
  String unitType;
  @HiveField(3)
  int stock;
  @HiveField(4)
  DateTime scannedAt;

  MaterialScanLog({
    required this.materialName,
    required this.unitCost,
    required this.unitType,
    required this.stock,
    required this.scannedAt,
  });
}