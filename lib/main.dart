import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_core/firebase_core.dart';
import 'screens/auth/auth_wrapper.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/admin/admin_dashboard.dart';
import 'screens/operator/operator_dashboard.dart';
import 'screens/admin/manage_materials.dart';
import 'screens/admin/manage_processes.dart';
import 'screens/admin/manage_users.dart';
import 'screens/admin/analytics.dart';
import 'screens/admin/export_reports.dart';
import 'screens/operator/scan_materials.dart';
import 'screens/operator/log_consumption.dart';
import 'screens/operator/assigned_operations.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCib8Ak39HnmLiVsm6xQMrWxWHNpbd3Dpc",
        authDomain: "external_mad.firebaseapp.com",
        projectId: "external_mad",
        storageBucket: "external_mad.appspot.com",
        messagingSenderId: "429164073739",
        appId: "1:429164073739:web:62fbc76fe6a13ee9a9880e",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Auth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthWrapper(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/adminDashboard': (context) => const AdminDashboard(),
        '/operatorDashboard': (context) => const OperatorDashboard(),
        '/manageMaterials': (context) => const ManageMaterialsScreen(),
        '/manageProcesses': (context) => const ManageProcessesScreen(),
        '/manageUsers': (context) => const ManageUsersScreen(),
        '/analytics': (context) => const AnalyticsScreen(),
        '/exportReports': (context) => const ExportReportsScreen(),
        '/operatorDashboard': (context) => const OperatorDashboard(),
        '/scanMaterials': (context) => const ScanMaterialsScreen(),
        '/logConsumption': (context) => const LogConsumptionScreen(),
        '/assignedOperations': (context) => const AssignedOperationsScreen()
      },
    );
  }
}