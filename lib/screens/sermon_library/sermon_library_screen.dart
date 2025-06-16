import 'package:flutter/material.dart';
import 'package:the_good_shepherd/theme/app_theme.dart';

class SermonLibraryScreen extends StatelessWidget {
  const SermonLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sermons = [
      {
        'title': 'The Power of Prayer',
        'description':
            'Discover how prayer can transform your life and bring you closer to God.',
        'date': '2025-06-14',
      },
      {
        'title': 'Walking in Faith',
        'description': 'A message about trusting God in every circumstance.',
        'date': '2025-06-13',
      },
      {
        'title': 'Serving with Love',
        'description': 'How to serve others with a Christ-like heart.',
        'date': '2025-06-12',
      },
      {
        'title': 'Hope in Uncertainty',
        'description': 'Finding hope and peace in uncertain times.',
        'date': '2025-06-11',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sermon Library'),
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
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: Icon(
                Icons.menu_book,
                color: AppTheme.primaryColor,
                size: 32,
              ),
              title: Text(
                sermon['title']!,
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
                    sermon['description']!,
                    style: TextStyle(
                      color: AppTheme.primaryTextColor.withOpacity(0.85),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Date: ${sermon['date']}',
                    style: TextStyle(
                      color: AppTheme.secondaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.play_circle_filled,
                  color: Colors.green,
                  size: 36,
                ),
                onPressed: () {},
                tooltip: 'Play Sermon',
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
