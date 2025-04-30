import 'package:flutter/material.dart';
import '../../models/process_model.dart';

class ManageProcessesScreen extends StatefulWidget {
  const ManageProcessesScreen({super.key});

  @override
  State<ManageProcessesScreen> createState() => _ManageProcessesScreenState();
}

class _ManageProcessesScreenState extends State<ManageProcessesScreen> {
  List<ProcessItem> processes = [
    ProcessItem(name: 'Cutting', description: 'Cutting raw material to size', additionalCost: 20.0),
    ProcessItem(name: 'Welding', description: 'Joining parts by welding', additionalCost: 50.0),
    ProcessItem(name: 'Painting', description: 'Applying protective paint', additionalCost: 15.0),
  ];

  void _addOrEditProcess({ProcessItem? item, int? index}) async {
    final result = await showDialog<ProcessItem>(
      context: context,
      builder: (context) => ProcessDialog(item: item),
    );
    if (result != null) {
      setState(() {
        if (index != null) {
          processes[index] = result;
        } else {
          processes.add(result);
        }
      });
    }
  }

  void _deleteProcess(int index) {
    setState(() {
      processes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Processes'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: processes.length,
        itemBuilder: (context, index) {
          final item = processes[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${item.description}\nAdditional Cost: ₹${item.additionalCost}'),
              isThreeLine: true,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _addOrEditProcess(item: item, index: index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteProcess(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () => _addOrEditProcess(),
        child: const Icon(Icons.add),
        tooltip: 'Add Process',
      ),
    );
  }
}

class ProcessDialog extends StatefulWidget {
  final ProcessItem? item;
  const ProcessDialog({super.key, this.item});

  @override
  State<ProcessDialog> createState() => _ProcessDialogState();
}

class _ProcessDialogState extends State<ProcessDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descController;
  late TextEditingController _costController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item?.name ?? '');
    _descController = TextEditingController(text: widget.item?.description ?? '');
    _costController = TextEditingController(text: widget.item?.additionalCost.toString() ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _costController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.item == null ? 'Add Process' : 'Edit Process'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Process Name'),
                validator: (value) => value == null || value.isEmpty ? 'Enter name' : null,
              ),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) => value == null || value.isEmpty ? 'Enter description' : null,
              ),
              TextFormField(
                controller: _costController,
                decoration: const InputDecoration(labelText: 'Additional Cost'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Enter cost' : null,
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
                ProcessItem(
                  name: _nameController.text,
                  description: _descController.text,
                  additionalCost: double.tryParse(_costController.text) ?? 0,
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