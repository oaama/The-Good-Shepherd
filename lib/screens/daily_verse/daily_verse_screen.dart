import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_good_shepherd/providers/daily_verse_provider.dart';
import 'package:the_good_shepherd/models/daily_verse.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_good_shepherd/theme/app_theme.dart';

class DailyVerseScreen extends StatefulWidget {
  const DailyVerseScreen({Key? key}) : super(key: key);

  @override
  State<DailyVerseScreen> createState() => _DailyVerseScreenState();
}

class _DailyVerseScreenState extends State<DailyVerseScreen> {
  bool _isLoading = true;
  bool _hasError = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _fetchDailyVerse();
  }

  Future<void> _fetchDailyVerse() async {
    try {
      setState(() {
        _isLoading = true;
        _hasError = false;
        _errorText = null;
      });

      final provider = Provider.of<DailyVerseProvider>(context, listen: false);
      await provider.fetchDailyVerse();
    } catch (e) {
      setState(() {
        _hasError = true;
        _errorText = 'حدث خطأ أثناء تحميل الآية اليومية';
      });
      Fluttertoast.showToast(
        msg: _errorText!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppTheme.churchRed, // Updated
        textColor: AppTheme.churchLightText, // Updated
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Verse'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: AppTheme.backgroundColor,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _hasError
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _errorText!,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _fetchDailyVerse,
                        child: const Text('إعادة المحاولة'),
                      ),
                    ],
                  ),
                )
              : Consumer<DailyVerseProvider>(
                  builder: (context, provider, child) {
                    final verse = provider.dailyVerse!;
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Card(
                            color: AppTheme.surfaceColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    verse.text,
                                    style: TextStyle(
                                      color: AppTheme.churchBlue, // Updated
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ).animate().fadeIn(duration: 300.ms),
                                  const SizedBox(height: 16),
                                  Text(
                                    verse.reference,
                                    style: TextStyle(
                                      color: AppTheme.churchGold, // Updated
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ).animate().fadeIn(delay: 100.ms),
                                  const SizedBox(height: 24),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        color: AppTheme.churchGold, // Updated
                                      ).animate().fadeIn(delay: 200.ms),
                                      const SizedBox(width: 8),
                                      Text('${verse.likes}', style: Theme.of(context).textTheme.bodyMedium).animate().fadeIn(delay: 200.ms), // Use theme text
                                      const SizedBox(width: 16),
                                      Icon(
                                        Icons.share,
                                        color: AppTheme.churchGold, // Updated
                                      ).animate().fadeIn(delay: 300.ms),
                                      const SizedBox(width: 8),
                                      Text('${verse.shares}', style: Theme.of(context).textTheme.bodyMedium).animate().fadeIn(delay: 300.ms), // Use theme text
                                      const Spacer(),
                                      IconButton(
                                        icon: Icon(Icons.bookmark_border, color: AppTheme.churchGold), // Updated
                                        onPressed: () {
                                          Fluttertoast.showToast(
                                            msg: 'تم حفظ الآية',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            backgroundColor: AppTheme.churchBlue, // Updated
                                            textColor: AppTheme.churchLightText, // Updated
                                          );
                                        },
                                      ).animate().fadeIn(delay: 400.ms),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: () {
                              final verseText = Provider.of<DailyVerseProvider>(context, listen: false).dailyVerse?.text ?? "No verse";
                              final verseReference = Provider.of<DailyVerseProvider>(context, listen: false).dailyVerse?.reference ?? "";
                              print('Sharing verse: $verseText ($verseReference)');
                              Fluttertoast.showToast(msg: "Share action triggered for verse");
                            },
                            icon: const Icon(Icons.share),
                            label: const Text('Share Verse'),
                            // Style will be inherited from ElevatedButtonTheme
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
