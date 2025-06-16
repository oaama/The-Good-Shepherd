import 'package:flutter/material.dart';
import 'package:the_good_shepherd/theme/app_theme.dart';

class SermonsScreen extends StatelessWidget {
  const SermonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sermons = [
      {
        'title': 'The Power of Prayer',
        'description':
            'Discover how prayer can transform your life and bring you closer to God.',
        'date': DateTime(2025, 6, 14),
      },
      {
        'title': 'Walking in Faith',
        'description': 'A message about trusting God in every circumstance.',
        'date': DateTime(2025, 6, 13),
      },
      {
        'title': 'Serving with Love',
        'description': 'How to serve others with a Christ-like heart.',
        'date': DateTime(2025, 6, 12),
      },
      {
        'title': 'Hope in Uncertainty',
        'description': 'Finding hope and peace in uncertain times.',
        'date': DateTime(2025, 6, 11),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sermons'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: AppTheme.backgroundColor,
      body: ListView.builder(
        padding: const EdgeInsets.all(18),
        itemCount: sermons.length,
        itemBuilder: (context, index) {
          final sermon = sermons[index];
          return Card(
            color: AppTheme.surfaceColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text(
                sermon['title'] as String,
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    sermon['description'] as String,
                    style: TextStyle(
                      color: AppTheme.primaryTextColor.withOpacity(0.85),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Date: ${(sermon['date'] as DateTime).toLocal().toString().split(' ')[0]}',
                    style: TextStyle(
                      color: AppTheme.secondaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
