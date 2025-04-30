class AppUser {
  final String email;
  final String password;
  final String role; // 'admin' or 'operator'

  AppUser({required this.email, required this.password, required this.role});
}

// Hardcoded users
final List<AppUser> users = [
  AppUser(email: 'admin@smartfab.com', password: 'admin123', role: 'admin'),
  AppUser(email: 'operator@smartfab.com', password: 'operator123', role: 'operator'),
];