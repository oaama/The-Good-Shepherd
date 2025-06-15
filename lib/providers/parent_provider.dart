import 'package:flutter/material.dart';

class ParentProvider extends ChangeNotifier {
  // Example dummy state
  String _parentName = 'Parent Example';
  int _childrenCount = 2;

  String get parentName => _parentName;
  int get childrenCount => _childrenCount;

  void updateParent(String name, int count) {
    // TODO: Implement real update logic
    _parentName = name;
    _childrenCount = count;
    notifyListeners();
  }
}
