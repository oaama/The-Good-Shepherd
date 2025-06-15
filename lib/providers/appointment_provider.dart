import 'package:flutter/material.dart';
import 'package:the_good_shepherd/services/api_service.dart';
import 'package:the_good_shepherd/services/error_handler.dart';

/// AppointmentProvider manages scheduling and fetching appointments.
class AppointmentProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  List<Map<String, dynamic>> _appointments = [];

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Map<String, dynamic>> get appointments => _appointments;

  /// Schedule a new appointment
  Future<void> scheduleAppointment({
    required DateTime date,
    required String time,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    // MOCK DATA INJECTION
    _appointments.add({
      'date': date.toIso8601String().split('T')[0],
      'time': time,
    });
    _isLoading = false;
    notifyListeners();
    // TODO: Replace with real backend endpoint
  }

  /// Fetch list of appointments
  Future<void> getAppointments() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    // MOCK DATA INJECTION
    _appointments = [
      {'date': '2025-06-15', 'time': '10:00 AM'},
      {'date': '2025-06-20', 'time': '12:30 PM'},
    ];
    _isLoading = false;
    notifyListeners();
    // TODO: Replace with real backend endpoint
  }
}
