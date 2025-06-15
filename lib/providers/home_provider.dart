import 'package:flutter/material.dart';
import '../models/verse.dart';
import '../models/announcement.dart';
import '../services/verse_service.dart';

class HomeProvider extends ChangeNotifier {
  Verse? _dailyVerse;
  String? _spiritualQuote;
  List<Announcement> _announcements = [];

  Verse? get dailyVerse => _dailyVerse;
  String? get spiritualQuote => _spiritualQuote;
  List<Announcement> get announcements => _announcements;

  Future<void> fetchDailyVerse() async {
    _dailyVerse = await VerseService().getDailyVerse();
    notifyListeners();
  }

  Future<void> fetchSpiritualQuote() async {
    // TODO: Fetch from API or static list
    _spiritualQuote = "Be still, and know that I am God.";
    notifyListeners();
  }

  void loadAnnouncements() {
    // TODO: Load from backend
    _announcements = [
      Announcement(
        title: "Youth Meeting",
        description: "Every Friday at 7pm.",
        date: DateTime.now(),
      ),
      Announcement(
        title: "Confession Appointments",
        description: "Book with your spiritual father.",
        date: DateTime.now(),
      ),
    ];
    notifyListeners();
  }
}
