import 'package:flutter/material.dart';
import '../../models/assigned_operation.dart';

class AssignedOperationsScreen extends StatefulWidget {
  const AssignedOperationsScreen({super.key});

  @override
  State<AssignedOperationsScreen> createState() => _AssignedOperationsScreenState();
}

class _AssignedOperationsScreenState extends State<AssignedOperationsScreen> {
  List<AssignedOperation> operations = [
    AssignedOperation(
      operationName: 'Cutting Batch #1',
      materialName: 'Steel Rod',
      description: 'Cut 20kg of steel rods to 1m length.',
      status: 'Pending',
      assignedAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    AssignedOperation(
      operationName: 'Welding Batch #2',
      materialName: 'Copper Wire',
      description: 'Weld copper wires for circuit assembly.',
      status: 'In Progress',
      assignedAt: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    AssignedOperation(
      operationName: 'Painting Batch #3',
      materialName: 'Plastic Sheet',
      description: 'Paint 50 sq.m of plastic sheets.',
      status: 'Completed',
      assignedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  String filterStatus = 'All';

  void _updateStatus(int index, String newStatus) {
    setState(() {
      operations[index].status = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<AssignedOperation> filteredOps = filterStatus == 'All'
        ? operations
        : operations.where((op) => op.status == filterStatus).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assigned Operations'),
        backgroundColor: Colors.blue,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) => setState(() => filterStatus = value),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'All', child: Text('All')),
              const PopupMenuItem(value: 'Pending', child: Text('Pending')),
              const PopupMenuItem(value: 'In Progress', child: Text('In Progress')),
              const PopupMenuItem(value: 'Completed', child: Text('Completed')),
            ],
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredOps.length,
        itemBuilder: (context, index) {
          final op = filteredOps[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Icon(
                op.status == 'Completed'
                    ? Icons.check_circle
                    : op.status == 'In Progress'
                        ? Icons.timelapse
                        : Icons.pending_actions,
                color: op.status == 'Completed'
                    ? Colors.green
                    : op.status == 'In Progress'
                        ? Colors.orange
                        : Colors.grey,
                size: 32,
              ),
              title: Text(op.operationName, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                '${op.materialName}\n${op.description}\nAssigned: ${op.assignedAt}',
              ),
              isThreeLine: true,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (op.status == 'Pending')
                    ElevatedButton(
                      onPressed: () => _updateStatus(operations.indexOf(op), 'In Progress'),
                      child: const Text('Start'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                    ),
                  if (op.status == 'In Progress')
                    ElevatedButton(
                      onPressed: () => _updateStatus(operations.indexOf(op), 'Completed'),
                      child: const Text('Complete'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    ),
                  if (op.status == 'Completed')
                    const Text('Done', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}