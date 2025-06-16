import 'package:flutter/material.dart';
import 'package:the_good_shepherd/models/sermon.dart';
import 'package:the_good_shepherd/services/api_service.dart';

class SermonProvider extends ChangeNotifier {
  final ApiService apiService;
  List<Sermon> _sermons = [];
  bool _loading = false;
  String? _error;

  SermonProvider({required this.apiService});

  List<Sermon> get sermons => _sermons;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> loadDummySermons() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _sermons = await apiService.fetchSermons();
    } catch (e) {
      _error = 'Failed to load sermons';
    }
    _loading = false;
    notifyListeners();
  }

  void addSermon(Sermon sermon) {
    _sermons.add(sermon);
    notifyListeners();
  }
}
