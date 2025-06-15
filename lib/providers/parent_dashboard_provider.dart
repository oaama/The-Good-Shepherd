import 'package:flutter/material.dart';

/// ParentDashboardProvider manages child behavior data for parents.
class ParentDashboardProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  Map<String, dynamic>? _childData;

  bool get isLoading => _isLoading;
  String? get error => _error;
  Map<String, dynamic>? get childData => _childData;

  /// Fetch child behavior data (dummy static data for now)
  Future<void> fetchChildData(String childId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    // MOCK DATA INJECTION
    _childData = {
      'name': 'Mina Youssef',
      'behaviorScore': 92,
      'riskScore': 8,
      'advice': 'Encourage more group activities and prayer.',
      'flags': [
        {'label': 'Porn Risk', 'active': false},
        {'label': 'Depression', 'active': true},
        {'label': 'Bullying', 'active': false},
        {'label': 'Attendance', 'active': false},
        {'label': 'Late Night Out', 'active': true},
      ],
    };
    _isLoading = false;
    notifyListeners();
    // TODO: Replace with real backend call
    return;
  }
}
