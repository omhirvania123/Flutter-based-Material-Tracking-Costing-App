class AdminUser {
  String name;
  String email;
  String role; // 'admin' or 'operator'

  AdminUser({required this.name, required this.email, required this.role});
}