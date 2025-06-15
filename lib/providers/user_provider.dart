import 'package:flutter/material.dart';
import 'package:the_good_shepherd/services/api_service.dart';
import 'package:the_good_shepherd/services/error_handler.dart';
import 'package:the_good_shepherd/models/user.dart';

/// UserProvider manages user profile and account actions.
class UserProvider extends ChangeNotifier {
  User? _profile;
  bool _isLoading = false;
  String? _error;

  User? get profile => _profile;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Load user profile
  Future<void> loadProfile() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    // MOCK DATA INJECTION
    _profile = User(
      id: '1',
      fullName: 'Mina Youssef',
      email: 'mina@example.com',
      phone: '+20123456789',
      age: 22,
      gender: 'Male',
    );
    _isLoading = false;
    notifyListeners();
    // TODO: Replace with real backend endpoint
  }

  /// Edit user profile
  Future<void> editProfile({
    required String fullName,
    required String phone,
    required String email,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      // TODO: Replace with real backend endpoint
      final response = await ApiService().put(
        '/user/profile',
        data: {'fullName': fullName, 'phone': phone, 'email': email},
      );
      if (response.statusCode == 200) {
        _profile = User.fromJson(response.data);
      } else {
        _error = response.data['message'] ?? 'Failed to update profile';
      }
    } catch (e) {
      _error = ErrorHandler.getErrorMessage(e);
    }
    _isLoading = false;
    notifyListeners();
  }

  /// Change user password
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      // TODO: Replace with real backend endpoint
      final response = await ApiService().put(
        '/user/change-password',
        data: {'oldPassword': oldPassword, 'newPassword': newPassword},
      );
      if (response.statusCode == 200) {
        _error = null;
      } else {
        _error = response.data['message'] ?? 'Failed to change password';
      }
    } catch (e) {
      _error = ErrorHandler.getErrorMessage(e);
    }
    _isLoading = false;
    notifyListeners();
  }
}
