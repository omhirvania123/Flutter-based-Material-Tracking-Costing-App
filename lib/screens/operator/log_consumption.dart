import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../models/consumption_log.dart';

final List<Map<String, dynamic>> demoMaterials = [
  {
    'name': 'Steel Rod',
    'unitCost': 50.0,
    'unitType': 'kg',
  },
  {
    'name': 'Copper Wire',
    'unitCost': 120.0,
    'unitType': 'meter',
  },
  {
    'name': 'Plastic Sheet',
    'unitCost': 20.0,
    'unitType': 'sq.m',
  },
];

class LogConsumptionScreen extends StatefulWidget {
  const LogConsumptionScreen({super.key});

  @override
  State<LogConsumptionScreen> createState() => _LogConsumptionScreenState();
}

class _LogConsumptionScreenState extends State<LogConsumptionScreen> {
  String? selectedMaterial;
  double? unitCost;
  String? unitType;
  final _quantityController = TextEditingController();
  final _additionalCostController = TextEditingController();
  final _marginController = TextEditingController();

  double? totalCost;
  double? manufacturingCost;
  double? finalProductPrice;
  double? suggestedSellingPricePerUnit;
  double? profitMarginPerUnit;

  List<ConsumptionLog> logs = [];

  @override
  void initState() {
    super.initState();
    _loadLogs();
  }

  Future<void> _loadLogs() async {
    final box = await Hive.openBox<ConsumptionLog>('consumptionLogs');
    setState(() {
      logs = box.values.toList();
    });
  }

  Future<void> _saveLog(ConsumptionLog log) async {
    final box = await Hive.openBox<ConsumptionLog>('consumptionLogs');
    await box.add(log);
    _loadLogs();
  }

  void _onMaterialChanged(String? value) {
    final mat = demoMaterials.firstWhere((m) => m['name'] == value);
    setState(() {
      selectedMaterial = value;
      unitCost = mat['unitCost'];
      unitType = mat['unitType'];
      totalCost = null;
      manufacturingCost = null;
      finalProductPrice = null;
      suggestedSellingPricePerUnit = null;
      profitMarginPerUnit = null;
      _quantityController.clear();
      _additionalCostController.clear();
      _marginController.clear();
    });
  }

  void _calculateCost() {
    if (unitCost != null && _quantityController.text.isNotEmpty) {
      final qty = double.tryParse(_quantityController.text) ?? 0;
      final rawMaterialCost = unitCost! * qty;
      final additionalCost = double.tryParse(_additionalCostController.text) ?? 0;
      manufacturingCost = rawMaterialCost + additionalCost;
      final margin = double.tryParse(_marginController.text) ?? 0;
      finalProductPrice = manufacturingCost! + margin;
      suggestedSellingPricePerUnit = qty == 0 ? 0 : finalProductPrice! / qty;
      profitMarginPerUnit = qty == 0 ? 0 : suggestedSellingPricePerUnit! - (manufacturingCost! / qty);
      setState(() {
        totalCost = rawMaterialCost;
      });
    }
  }

  void _logConsumption() {
    if (selectedMaterial != null &&
        unitCost != null &&
        unitType != null &&
        totalCost != null &&
        manufacturingCost != null &&
        finalProductPrice != null &&
        suggestedSellingPricePerUnit != null &&
        profitMarginPerUnit != null) {
      final qty = double.tryParse(_quantityController.text) ?? 0;
      final log = ConsumptionLog(
        materialName: selectedMaterial!,
        unitCost: unitCost!,
        unitType: unitType!,
        quantityUsed: qty,
        totalCost: totalCost!,
        manufacturingCost: manufacturingCost!,
        finalProductPrice: finalProductPrice!,
        suggestedSellingPricePerUnit: suggestedSellingPricePerUnit!,
        profitMarginPerUnit: profitMarginPerUnit!,
        loggedAt: DateTime.now(),
      );
      _saveLog(log);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Consumption logged!')),
      );
      setState(() {
        selectedMaterial = null;
        unitCost = null;
        unitType = null;
        totalCost = null;
        manufacturingCost = null;
        finalProductPrice = null;
        suggestedSellingPricePerUnit = null;
        profitMarginPerUnit = null;
        _quantityController.clear();
        _additionalCostController.clear();
        _marginController.clear();
      });
    }
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _additionalCostController.dispose();
    _marginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Consumption'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedMaterial,
              items: demoMaterials
                  .map((mat) => DropdownMenuItem<String>(
                        value: mat['name'] as String,
                        child: Text(mat['name'] as String),
                      ))
                  .toList(),
              onChanged: _onMaterialChanged,
              decoration: const InputDecoration(labelText: 'Select Material'),
            ),
            const SizedBox(height: 16),
            if (selectedMaterial != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Unit Cost: ₹$unitCost / $unitType'),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Quantity Used',
                    ),
                    onChanged: (_) => _calculateCost(),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _additionalCostController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Additional Processing Costs (labor, energy, etc.)',
                    ),
                    onChanged: (_) => _calculateCost(),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _marginController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Desired Margin (₹)',
                    ),
                    onChanged: (_) => _calculateCost(),
                  ),
                  const SizedBox(height: 8),
                  if (totalCost != null)
                    Text('Raw Material Cost: ₹${totalCost!.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  if (manufacturingCost != null)
                    Text('Manufacturing Cost: ₹${manufacturingCost!.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  if (finalProductPrice != null)
                    Text('Final Product Price: ₹${finalProductPrice!.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  if (suggestedSellingPricePerUnit != null)
                    Text('Suggested Selling Price per unit: ₹${suggestedSellingPricePerUnit!.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  if (profitMarginPerUnit != null)
                    Text('Profit Margin per unit: ₹${profitMarginPerUnit!.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: (totalCost != null && _quantityController.text.isNotEmpty)
                        ? _logConsumption
                        : null,
                    icon: const Icon(Icons.save),
                    label: const Text('Log Consumption'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  ),
                ],
              ),
            const SizedBox(height: 24),
            const Text('Logged Consumptions (Offline Cached):', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: logs.length,
                itemBuilder: (context, index) {
                  final log = logs[index];
                  return ListTile(
                    leading: const Icon(Icons.edit_note),
                    title: Text(log.materialName),
                    subtitle: Text(
                      'Qty: ${log.quantityUsed} ${log.unitType} | Raw Cost: ₹${log.totalCost}\n'
                      'Mfg Cost: ₹${log.manufacturingCost} | Final Price: ₹${log.finalProductPrice}\n'
                      'Sell/unit: ₹${log.suggestedSellingPricePerUnit} | Profit/unit: ₹${log.profitMarginPerUnit}\n'
                      'Logged at: ${log.loggedAt}',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}