import 'package:flutter/material.dart';
import '../../models/material_model.dart';

class ManageMaterialsScreen extends StatefulWidget {
  const ManageMaterialsScreen({super.key});

  @override
  State<ManageMaterialsScreen> createState() => _ManageMaterialsScreenState();
}

class _ManageMaterialsScreenState extends State<ManageMaterialsScreen> {
  List<MaterialItem> materials = [
    MaterialItem(name: 'Steel Rod', unitCost: 50.0, unitType: 'kg', stock: 120),
    MaterialItem(name: 'Copper Wire', unitCost: 120.0, unitType: 'meter', stock: 300),
    MaterialItem(name: 'Plastic Sheet', unitCost: 20.0, unitType: 'sq.m', stock: 500),
  ];

  void _addOrEditMaterial({MaterialItem? item, int? index}) async {
    final result = await showDialog<MaterialItem>(
      context: context,
      builder: (context) => MaterialDialog(item: item),
    );
    if (result != null) {
      setState(() {
        if (index != null) {
          materials[index] = result;
        } else {
          materials.add(result);
        }
      });
    }
  }

  void _deleteMaterial(int index) {
    setState(() {
      materials.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Materials'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: materials.length,
        itemBuilder: (context, index) {
          final item = materials[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Unit Cost: ₹${item.unitCost} / ${item.unitType}\nStock: ${item.stock}'),
              isThreeLine: true,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _addOrEditMaterial(item: item, index: index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteMaterial(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () => _addOrEditMaterial(),
        child: const Icon(Icons.add),
        tooltip: 'Add Material',
      ),
    );
  }
}

class MaterialDialog extends StatefulWidget {
  final MaterialItem? item;
  const MaterialDialog({super.key, this.item});

  @override
  State<MaterialDialog> createState() => _MaterialDialogState();
}

class _MaterialDialogState extends State<MaterialDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _unitCostController;
  late TextEditingController _unitTypeController;
  late TextEditingController _stockController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item?.name ?? '');
    _unitCostController = TextEditingController(text: widget.item?.unitCost.toString() ?? '');
    _unitTypeController = TextEditingController(text: widget.item?.unitType ?? '');
    _stockController = TextEditingController(text: widget.item?.stock.toString() ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _unitCostController.dispose();
    _unitTypeController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.item == null ? 'Add Material' : 'Edit Material'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Material Name'),
                validator: (value) => value == null || value.isEmpty ? 'Enter name' : null,
              ),
              TextFormField(
                controller: _unitCostController,
                decoration: const InputDecoration(labelText: 'Unit Cost'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Enter unit cost' : null,
              ),
              TextFormField(
                controller: _unitTypeController,
                decoration: const InputDecoration(labelText: 'Unit Type'),
                validator: (value) => value == null || value.isEmpty ? 'Enter unit type' : null,
              ),
              TextFormField(
                controller: _stockController,
                decoration: const InputDecoration(labelText: 'Stock'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Enter stock' : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.pop(
                context,
                MaterialItem(
                  name: _nameController.text,
                  unitCost: double.tryParse(_unitCostController.text) ?? 0,
                  unitType: _unitTypeController.text,
                  stock: int.tryParse(_stockController.text) ?? 0,
                ),
              );
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}