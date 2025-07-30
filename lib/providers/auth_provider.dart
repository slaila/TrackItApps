// providers/auth_provider.dart
import 'package:flutter/material.dart';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void login(String email, String password) {
    // Implement actual login logic
    _user = User(
      id: '1',
      name: 'Example User',
      email: email,
      password: password,
    );
    notifyListeners();
  }

  void register(String name, String email, String password) {
    // Implement actual registration logic
    _user = User(
      id: '1',
      name: name,
      email: email,
      password: password,
    );
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}