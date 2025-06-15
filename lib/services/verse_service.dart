import '../models/verse.dart';

class VerseService {
  Future<Verse> getDailyVerse() async {
    // TODO: Fetch from API
    await Future.delayed(const Duration(milliseconds: 500));
    return Verse(
      text:
          "I am the good shepherd. The good shepherd lays down his life for the sheep.",
      reference: "John 10:11",
    );
  }
}
