import 'package:flutter/material.dart';
import '../models/daily_verse.dart';
import '../services/api_service.dart';

class DailyVerseProvider with ChangeNotifier {
  DailyVerse? _dailyVerse;
  bool _isLoading = false;
  String? _error;

  DailyVerse? get dailyVerse => _dailyVerse;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchDailyVerse() async {
    if (_isLoading) return;

    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final apiService = ApiService();
      _dailyVerse = await apiService.fetchDailyVerse();
      notifyListeners();
    } catch (e) {
      _error = 'حدث خطأ أثناء تحميل الآية اليومية';
      notifyListeners();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> likeVerse() async {
    if (_isLoading) return;

    try {
      _isLoading = true;
      notifyListeners();

      if (_dailyVerse != null) {
        _dailyVerse = _dailyVerse!.copyWith(likes: _dailyVerse!.likes + 1);
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

  Future<void> shareVerse() async {
    if (_isLoading) return;

    try {
      _isLoading = true;
      notifyListeners();

      if (_dailyVerse != null) {
        _dailyVerse = _dailyVerse!.copyWith(shares: _dailyVerse!.shares + 1);
        notifyListeners();
      }
    } catch (e) {
      _error = 'حدث خطأ أثناء مشاركة الآية';
      notifyListeners();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
