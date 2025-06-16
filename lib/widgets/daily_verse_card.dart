import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class DailyVerseCard extends StatelessWidget {
  final String reference;
  final String verse;

  const DailyVerseCard({
    super.key,
    required this.reference,
    required this.verse,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.cream,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              reference,
              style: TextStyle(
                color: AppTheme.darkBlue,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              verse,
              style: TextStyle(
                color: AppTheme.darkBlue.withOpacity(0.95),
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
