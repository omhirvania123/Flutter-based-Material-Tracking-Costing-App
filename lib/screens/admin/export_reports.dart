import 'package:flutter/material.dart';

class ExportReportsScreen extends StatelessWidget {
  const ExportReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Demo data: material exports
    final exports = [
      {'material': 'Steel Rod', 'quantity': 50, 'date': '2024-05-01'},
      {'material': 'Copper Wire', 'quantity': 100, 'date': '2024-05-02'},
      {'material': 'Plastic Sheet', 'quantity': 30, 'date': '2024-05-03'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Export Reports'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text('Exported Materials', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            DataTable(
              columns: const [
                DataColumn(label: Text('Material')),
                DataColumn(label: Text('Quantity')),
                DataColumn(label: Text('Date')),
              ],
              rows: exports.map((e) {
                return DataRow(cells: [
                  DataCell(Text(e['material'].toString())),
                  DataCell(Text(e['quantity'].toString())),
                  DataCell(Text(e['date'].toString())),
                ]);
              }).toList(),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Exported as CSV (demo only)')),
                );
              },
              icon: const Icon(Icons.file_download),
              label: const Text('Export as CSV'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),
          ],
        ),
      ),
    );
  }
}