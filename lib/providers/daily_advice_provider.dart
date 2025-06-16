import 'package:flutter/material.dart';
import '../models/daily_advice.dart';
import '../services/api_service.dart';

class DailyAdviceProvider with ChangeNotifier {
  DailyAdvice? _dailyAdvice;
  bool _isLoading = false;
  String? _error;

  DailyAdvice? get dailyAdvice => _dailyAdvice;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchDailyAdvice() async {
    if (_isLoading) return;

    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final apiService = ApiService();
      _dailyAdvice = await apiService.fetchDailyAdvice();
      notifyListeners();
    } catch (e) {
      _error = 'حدث خطأ أثناء تحميل النصيحة اليومية';
      notifyListeners();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> likeAdvice() async {
    if (_isLoading) return;

    try {
      _isLoading = true;
      notifyListeners();

      if (_dailyAdvice != null) {
        _dailyAdvice = _dailyAdvice!.copyWith(likes: _dailyAdvice!.likes + 1);
        notifyListeners();
      }
    } catch (e) {
      _error = 'حدث خطأ أثناء إضافة الإعجاب';
      notifyListeners();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
