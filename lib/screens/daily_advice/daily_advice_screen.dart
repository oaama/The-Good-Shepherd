import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_good_shepherd/providers/daily_advice_provider.dart';
import 'package:the_good_shepherd/models/daily_advice.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_good_shepherd/theme/app_theme.dart';

class DailyAdviceScreen extends StatefulWidget {
  const DailyAdviceScreen({Key? key}) : super(key: key);

  @override
  State<DailyAdviceScreen> createState() => _DailyAdviceScreenState();
}

class _DailyAdviceScreenState extends State<DailyAdviceScreen> {
  bool _isLoading = true;
  bool _hasError = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _fetchDailyAdvice();
  }

  Future<void> _fetchDailyAdvice() async {
    try {
      setState(() {
        _isLoading = true;
        _hasError = false;
        _errorText = null;
      });

      final provider = Provider.of<DailyAdviceProvider>(context, listen: false);
      await provider.fetchDailyAdvice();
    } catch (e) {
      setState(() {
        _hasError = true;
        _errorText = 'حدث خطأ أثناء تحميل النصيحة اليومية';
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
        title: const Text('Daily Advice'),
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
                        onPressed: _fetchDailyAdvice,
                        child: const Text('إعادة المحاولة'),
                      ),
                    ],
                  ),
                )
              : Consumer<DailyAdviceProvider>(
                  builder: (context, provider, child) {
                    final advice = provider.dailyAdvice!;
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
                                    advice.advice,
                                    style: TextStyle(
                                      color: AppTheme.churchBlue, // Updated
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ).animate().fadeIn(duration: 300.ms),
                                  const SizedBox(height: 16),
                                  Text(
                                    advice.content,
                                    style: TextStyle(
                                      color: AppTheme.churchDarkText, // Updated
                                      fontSize: 16,
                                      height: 1.6,
                                    ),
                                  ).animate().fadeIn(delay: 100.ms),
                                  const SizedBox(height: 20),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '${advice.date.toLocal().toString().split(' ')[0]}',
                                      style: TextStyle(
                                        color: AppTheme.churchGold, // Updated
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: () {
                              final adviceText = Provider.of<DailyAdviceProvider>(context, listen: false).dailyAdvice?.advice ?? "No advice";
                              print('Saving advice: $adviceText');
                              Fluttertoast.showToast(msg: "Save for later action triggered for advice");
                            },
                            icon: const Icon(Icons.bookmark),
                            label: const Text('Save for Later'),
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
