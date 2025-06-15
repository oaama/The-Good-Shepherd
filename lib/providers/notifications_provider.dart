import 'package:flutter/material.dart';

/// NotificationsProvider manages notifications list and read status.
class NotificationsProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  List<Map<String, dynamic>> _notifications = [
    {'id': 1, 'title': 'Youth Meeting', 'body': 'Friday at 7pm', 'read': false},
    {
      'id': 2,
      'title': 'Confession',
      'body': 'Your appointment is tomorrow',
      'read': true,
    },
    {
      'id': 3,
      'title': 'Church Announcement',
      'body': 'New event next week',
      'read': false,
    },
    {
      'id': 4,
      'title': 'Retreat',
      'body': 'Bus leaves at 8am Saturday',
      'read': false,
    },
    {
      'id': 5,
      'title': 'Bible Study',
      'body': 'Wednesday 6pm in Hall B',
      'read': true,
    },
  ];

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Map<String, dynamic>> get notifications => _notifications;

  /// Fetch notifications (dummy static data for now)
  Future<void> fetchNotifications() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    // TODO: Replace with real backend call
    _isLoading = false;
    notifyListeners();
  }

  /// Mark notification as read
  Future<void> markAsRead(int id) async {
    final index = _notifications.indexWhere((n) => n['id'] == id);
    if (index != -1) {
      _notifications[index]['read'] = true;
      notifyListeners();
      // TODO: Add backend call: PUT /notifications/{id}
    }
  }
}
