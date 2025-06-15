import 'package:flutter/material.dart';
import 'package:the_good_shepherd/services/api_service.dart';
import 'package:the_good_shepherd/services/shared_prefs_service.dart';
import 'package:the_good_shepherd/services/error_handler.dart';
import 'package:the_good_shepherd/models/user.dart';

/// AuthProvider manages authentication state and logic.
class AuthProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String? _error;
  String? _token;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get token => _token;
  bool get isLoggedIn => _token != null && _token!.isNotEmpty;

  /// Login user with email and password
  Future<void> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    // MOCK DATA INJECTION
    _token = 'mock_token_123';
    await SharedPrefsService.saveToken(_token!);
    _user = User(
      id: '1',
      fullName: 'Mina Youssef',
      email: email,
      phone: '+20123456789',
      age: 22,
      gender: 'Male',
    );
    _error = null;
    _isLoading = false;
    notifyListeners();
    // TODO: Replace with real backend endpoint
  }

  /// Register a new user
  Future<void> register({
    required String fullName,
    required int age,
    required String gender,
    required String phone,
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    // MOCK DATA INJECTION
    _error = null;
    _isLoading = false;
    notifyListeners();
    // TODO: Replace with real backend endpoint
  }

  /// Logout user and clear token
  Future<void> logout() async {
    _user = null;
    _token = null;
    await SharedPrefsService.clearToken();
    notifyListeners();
  }

  /// Placeholder for token refresh logic
  Future<void> refreshToken() async {
    // TODO: Implement token refresh logic
  }
}
