import 'package:flutter/material.dart';
import '../services/panic_service.dart';

class PanicProvider extends ChangeNotifier {
  bool _isSending = false;
  String? _error;
  bool get isSending => _isSending;
  String? get error => _error;

  Future<void> sendPanic() async {
    _isSending = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    // MOCK DATA INJECTION: always success
    _error = null;
    _isSending = false;
    notifyListeners();
    // TODO: Integrate with backend
    return;
  }
}
