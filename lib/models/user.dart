// models/user.dart
class User {
  final String id;
  final String name;
  final String email;
  final String password; // Note: In real app, store hashed password only

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });
}