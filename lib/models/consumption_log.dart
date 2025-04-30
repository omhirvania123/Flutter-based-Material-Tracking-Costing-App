import 'package:hive/hive.dart';

part 'consumption_log.g.dart';

@HiveType(typeId: 1)
class ConsumptionLog extends HiveObject {
  @HiveField(0)
  String materialName;
  @HiveField(1)
  double unitCost;
  @HiveField(2)
  String unitType;
  @HiveField(3)
  double quantityUsed;
  @HiveField(4)
  double totalCost;
  @HiveField(5)
  double manufacturingCost;
  @HiveField(6)
  double finalProductPrice;
  @HiveField(7)
  double suggestedSellingPricePerUnit;
  @HiveField(8)
  double profitMarginPerUnit;
  @HiveField(9)
  DateTime loggedAt;

  ConsumptionLog({
    required this.materialName,
    required this.unitCost,
    required this.unitType,
    required this.quantityUsed,
    required this.totalCost,
    required this.manufacturingCost,
    required this.finalProductPrice,
    required this.suggestedSellingPricePerUnit,
    required this.profitMarginPerUnit,
    required this.loggedAt,
  });
}