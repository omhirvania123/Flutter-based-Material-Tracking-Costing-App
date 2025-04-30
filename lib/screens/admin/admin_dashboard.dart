import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // On logout, pop all routes and go to login
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            _DashboardButton(
              label: 'Manage Materials',
              icon: Icons.inventory,
              color: Colors.orange,
              onTap: () => Navigator.pushNamed(context, '/manageMaterials'),
            ),
            _DashboardButton(
              label: 'Manage Processes',
              icon: Icons.settings,
              color: Colors.blue,
              onTap: () => Navigator.pushNamed(context, '/manageProcesses'),
            ),
            _DashboardButton(
              label: 'Manage Users',
              icon: Icons.people,
              color: Colors.green,
              onTap: () => Navigator.pushNamed(context, '/manageUsers'),
            ),
            _DashboardButton(
              label: 'View Analytics',
              icon: Icons.analytics,
              color: Colors.pink,
              onTap: () => Navigator.pushNamed(context, '/analytics'),
            ),
            _DashboardButton(
              label: 'Export Reports',
              icon: Icons.file_download,
              color: Colors.teal,
              onTap: () => Navigator.pushNamed(context, '/exportReports'),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _DashboardButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 14),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(label, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
        onTap: onTap,
      ),
    );
  }
}