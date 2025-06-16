import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class DailyAdviceCard extends StatelessWidget {
  final String title;
  final String advice;

  const DailyAdviceCard({super.key, required this.title, required this.advice});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.lightGold.withOpacity(0.18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: AppTheme.darkBlue,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              advice,
              style: TextStyle(
                color: AppTheme.darkBlue.withOpacity(0.95),
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
