import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  User? currentUser;
  bool _isLoggedIn = false;
  String? _error;
  bool _isLoading = false;

  bool get isLoggedIn => _isLoggedIn;
  String? get error => _error;
  bool get isLoading => _isLoading;

  Future<void> login(String phone, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final user = await _authService.login(phone, password);
      currentUser = user;
      _isLoggedIn = true;
      _error = null;
    } catch (e) {
      _isLoggedIn = false;
      _error = 'Login failed: ${e.toString()}';
      currentUser = null;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> register({
    required String fullName,
    required String churchName,
    required String phoneNumber,
    required String area,
    required String address,
    required String password,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final user = await _authService.register(
        fullName: fullName,
        churchName: churchName,
        phoneNumber: phoneNumber,
        area: area,
        address: address,
        password: password,
      );
      currentUser = user;
      _isLoggedIn = true;
      _error = null;
    } catch (e) {
      _isLoggedIn = false;
      _error = 'Registration failed: ${e.toString()}';
      currentUser = null;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();
    try {
      await _authService.logout();
    } catch (_) {}
    currentUser = null;
    _isLoggedIn = false;
    _error = null;
    _isLoading = false;
    notifyListeners();
  }
}
